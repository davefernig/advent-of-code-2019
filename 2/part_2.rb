for noun in 0..100
  for verb in 0..100
    A = File
      .read('input.txt')
      .strip()
      .split(",")
      .collect {|x| x.to_i}

    A[1] = noun
    A[2] = verb
    
    index = 0  
    while A[index] != 99
      if A[index] == 1
        A[A[index+3]] = A[A[index+1]] + A[A[index+2]]
      else
        A[A[index+3]] = A[A[index+1]] * A[A[index+2]]
      end
      index += 4
    end
  
    if A[0] == 19690720
      result = [noun, verb]
    end
  end
end

puts 100 * result[0] + result[1]
