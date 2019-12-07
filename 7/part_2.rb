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

all_outputs = []

for config in [5,6,7,8,9].permutation.to_a

  amp = 0
  ptr = [0, 0, 0, 0, 0]
  mem = (0...5).collect {|_| A.dup}

  input_ptr = [0,0,0,0,0]
  inputs = config.collect {|x| [x]}
  inputs[0] += [0]

  while mem[4][ptr[4]] != 99

    a = mem[amp]

    instruction = parse_opcode a[ptr[amp]]
  
    p1 = instruction[1] == 0 ? a[a[ptr[amp]+1]] : a[ptr[amp]+1]
    p2 = instruction[2] == 0 ? a[a[ptr[amp]+2]] : a[ptr[amp]+2]
    p3 = instruction[3] == 0 ? a[ptr[amp]+3] : ptr[amp]+3
  
    case instruction[0]
 
    when 3 # Take input
      p1 = instruction[1] == 0 ? a[ptr[amp]+1] : ptr[amp]+1
      a[p1] = inputs[amp][input_ptr[amp]]
      ptr[amp] += 2
      input_ptr[amp] += 1
  
    when 4 # Produce output
      p1 = instruction[1] == 0 ? a[ptr[amp]+1] : ptr[amp]+1    
      index = amp==4 ? 0 : amp+1
      inputs[index] += [a[p1]]
      ptr[amp] += 2
      amp = amp==4 ? 0 : amp+1

    when 1 # Add
      a[p3] = p1 + p2
      ptr[amp] += 4
  
    when 2 # Multiply
      a[p3] = p1 * p2
      ptr[amp] += 4
  
    when 5 # Jump if true
      ptr[amp] = p1 != 0 ? p2 : ptr[amp] + 3 
  
    when 6 # Jump if false
      ptr[amp] = p1 == 0 ? p2 : ptr[amp] + 3
  
    when 7 # Less than
      a[p3] = p1 < p2 ? 1 : 0
      ptr[amp] += 4
  
    when 8 # Equals
      a[p3] = p1 == p2 ? 1 : 0
      ptr[amp] += 4
  
    else # Unknown opcode; should break
      puts "ERROR: UNKNOWN OPCODE"
      break
    end
  end

all_outputs += [inputs[0][-1]]
end

puts all_outputs.max
