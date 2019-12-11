A = File
  .read('input.txt')
  .strip()
  .split(",")
  .collect {|x| x.to_i}

puts A.size

A += (0...10000).collect {|_| 0}

def parse_opcode n
  opcode = n.to_s.rjust(5).gsub(' ', '0')
  [
    opcode[-2..-1].to_i,
    opcode[-3].to_i,
    opcode[-4].to_i,
    opcode[-5].to_i,
  ]
end

hull = (0..1000).collect {|x| [0]*1000}
copy = (0..1000).collect {|x| [0]*1000}
x = 500
y = 500

hull[y][x] = 1
copy[y][x] = 1

mode = 'color'
direction = 'u'

change_direction = {
  ['u', 0] => 'l',
  ['u', 1] => 'r',
  ['r', 0] => 'u',
  ['r', 1] => 'd',
  ['d', 0] => 'r',
  ['d', 1] => 'l',
  ['l', 0] => 'd',
  ['l', 1] => 'u',
}

def increment(d, x, y)
  case d
  when 'u'
    return [x, y+1]
  when 'd'
    return [x, y-1]
  when 'l'
    return [x-1, y]
  when 'r'
    return [x+1, y]
  end
end

relative_base = 0
index = 0
while A[index] != 99
  instructions = parse_opcode A[index]

  case instructions[1]
  when 0 
    p1 = A[A[index+1]]
  when 1
    p1 = A[index+1]
  when 2
    p1 = A[A[index+1] + relative_base]
  end

  case instructions[2]
  when 0 
    p2 = A[A[index+2]]
  when 1
    p2 = A[index+2]
  when 2
    p2 = A[A[index+2] + relative_base]
  end

  case instructions[3]
  when 0 
    p3 = A[index+3]
  when 1
    p3 = index+3
  when 2
    p3 = A[index+3] + relative_base
  end

  case instructions[0]
  when 3 # Take input
    if instructions[1] == 0
      p1 = A[index+1]
    elsif instructions[1] == 1
      p1 = index+1
    else
      p1 = A[index+1] + relative_base
    end

    if hull[y][x] == 0
      A[p1] = 0
    else
      A[p1] = 1
    end

    index += 2

  when 4 # Product output
    if instructions[1] == 0
      p1 = A[index+1]
    elsif instructions[1] == 1
      p1 = index+1
    else
      p1 = A[index+1] + relative_base
    end
    #puts A[p1]

    instruction = A[p1]

    puts mode + ' ' + instruction.to_s
    if mode == 'color'
      # First update actual space
      if instruction == 1
        hull[y][x] = 1
      else
        hull[y][x] = 0
      end

      # Then update the copy
      copy[y][x] = 1

      mode = 'move'
    elsif mode == 'move'    
      direction = change_direction[[direction, instruction]]
      new_position = increment(direction, x, y)
      x = new_position[0]
      y = new_position[1]
      mode = 'color'
    end

    index += 2

  when 1 # Add
    A[p3] = p1 + p2
    index += 4

  when 2 # Multiply
    A[p3] = p1 * p2
    index += 4

  when 5 # Jump if true
    index = p1 != 0 ? p2 : index + 3 

  when 6 # Jump if false
    index = p1 == 0 ? p2 : index + 3

  when 7 # Less than
    A[p3] = p1 < p2 ? 1 : 0
    index += 4

  when 8 # Equals
    A[p3] = p1 == p2 ? 1 : 0
    index += 4

  when 9 # Adjust relative base
    relative_base += p1
    index += 2

  else # Unknown opcode; should break
    puts "ERROR: UNKNOWN OPCODE"
    break
  end
end

human_readable = []
for row in hull
  if row.any? {|x| x > 0}
    human_readable = [((row[480..550].collect {|x| x==0 ? " " : "#"}).join "")] + human_readable
    #human_readable << (row[450..550].collect {|x| x==0 ? " " : "#"}).to_s
  end
end

for i in human_readable
  puts i
end 
