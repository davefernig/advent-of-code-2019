A = File
  .read('input.txt')
  .strip()
  .split(",")
  .collect {|x| x.to_i}

def parse_opcode n
  opcode = n.to_s.rjust(5).gsub(' ', '0')
  [
    opcode[-2..-1].to_i,
    opcode[-3].to_i,
    opcode[-4].to_i,
    opcode[-5].to_i,
  ]
end

index = 0
while A[index] != 99
  instructions = parse_opcode A[index]

  p1 = instructions[1] == 0 ? A[A[index+1]] : A[index+1]
  p2 = instructions[2] == 0 ? A[A[index+2]] : A[index+2]
  p3 = instructions[3] == 0 ? A[index+3] : index+3

  case instructions[0]

  when 3 # Take input
    p1 = instructions[1] == 0 ? A[index+1] : index+1
    A[p1] = 5
    index += 2

  when 4 # Product output
    p1 = instructions[1] == 0 ? A[index+1] : index+1
    puts "Output: " + A[p1].to_s
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

  else # Unknown opcode; should break
    puts "ERROR: UNKNOWN OPCODE"
    break
  end
end
