A = File
  .read('input.txt')
  .strip()
  .split(",")
  .collect {|x| x.to_i}

A += (0...10000000).collect {|_| 0}

def parse_opcode n
  opcode = n.to_s.rjust(5).gsub(' ', '0')
  [
    opcode[-2..-1].to_i,
    opcode[-3].to_i,
    opcode[-4].to_i,
    opcode[-5].to_i,
  ]
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

    A[p1] = 2
    index += 2

  when 4 # Product output
    if instructions[1] == 0
      p1 = A[index+1]
    elsif instructions[1] == 1
      p1 = index+1
    else
      p1 = A[index+1] + relative_base
    end
    puts A[p1]
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
