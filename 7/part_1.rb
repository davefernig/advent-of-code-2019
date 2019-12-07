A = File
  .read('input.txt')
  .strip()
  .split(",")
  .collect {|x| x.to_i}

# A = [3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0]

def parse_opcode n
  opcode = n.to_s.rjust(5).gsub(' ', '0')
  [
    opcode[-2..-1].to_i,
    opcode[-3].to_i,
    opcode[-4].to_i,
    opcode[-5].to_i,
  ]
end

score_to_input_setting = {}

for config in [0, 1, 2, 3, 4].permutation.to_a

  # Keep track of what we've seen
  thruster_outputs = [0]

  for thruster_input in config
    
    # Start some initialization stuff
    program_has_started = false

    # Now run the program
    index = 0
    while A[index] != 99
      instructions = parse_opcode A[index]
    
      if instructions[0] == 1
        p1 = instructions[1] == 0 ? A[A[index+1]] : A[index+1]
        p2 = instructions[2] == 0 ? A[A[index+2]] : A[index+2]
        p3 = instructions[3] == 0 ? A[index+3] : index+3
        A[p3] = p1 + p2
        index += 4
      end
    
      if instructions[0] == 2
        p1 = instructions[1] == 0 ? A[A[index+1]] : A[index+1]
        p2 = instructions[2] == 0 ? A[A[index+2]] : A[index+2]
        p3 = instructions[3] == 0 ? A[index+3] : index+3
        A[p3] = p1 * p2
        index += 4
      end
    
      if instructions[0] == 3
        p1 = instructions[1] == 0 ? A[index+1] : index+1
    
        input = program_has_started == false ? thruster_input : thruster_outputs[-1]
        program_has_started = !program_has_started

        A[p1] = input
    
        index += 2
      end
    
      if instructions[0] == 4
        p1 = instructions[1] == 0 ? A[index+1] : index+1
        # puts "Output: " + A[p1].to_s

        # Previous code
        # index += 2
        # break

        # New code
        # index = 99
        thruster_outputs += [A[p1]]
        
        if thruster_outputs.size == 6
          score_to_input_setting[A[p1]] = config
        end

        break

      end
    
      # Opcode 5 is jump-if-true: if the first parameter is non-zero,
      #          it sets the instruction pointer to the value from
      #          the second parameter. Otherwise, it does nothing.
      if instructions[0] == 5
        p1 = instructions[1] == 0 ? A[A[index+1]] : A[index+1]
        p2 = instructions[2] == 0 ? A[A[index+2]] : A[index+2]
        index = p1 != 0 ? p2 : index + 3 
      end
    
      # Opcode 6 is jump-if-false: if the first parameter is zero,
      #          it sets the instruction pointer to the value from
      #          the second parameter. Otherwise, it does nothing.
      if instructions[0] == 6
        p1 = instructions[1] == 0 ? A[A[index+1]] : A[index+1]
        p2 = instructions[2] == 0 ? A[A[index+2]] : A[index+2]
        index = p1 == 0 ? p2 : index + 3
      end
    
      # Opcode 7 is less than: if the first parameter is less than
      #          the second parameter, it stores 1 in the position
      #          given by the third parameter. Otherwise, it stores 0.
      if instructions[0] == 7
        p1 = instructions[1] == 0 ? A[A[index+1]] : A[index+1]
        p2 = instructions[2] == 0 ? A[A[index+2]] : A[index+2]
        p3 = instructions[3] == 0 ? A[index+3] : index+3
        A[p3] = p1 < p2 ? 1 : 0
        index += 4
      end
    
      # Opcode 8 is equals: if the first parameter is equal to the
      #          second parameter, it stores 1 in the position given
      #          by the third parameter. Otherwise, it stores 0.
      if instructions[0] == 8
        p1 = instructions[1] == 0 ? A[A[index+1]] : A[index+1]
        p2 = instructions[2] == 0 ? A[A[index+2]] : A[index+2]
        p3 = instructions[3] == 0 ? A[index+3] : index+3
        A[p3] = p1 == p2 ? 1 : 0
        index += 4
      end
    end
  end
end

puts score_to_input_setting.keys.max
