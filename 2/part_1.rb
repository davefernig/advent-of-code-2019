A = File
  .read('input.txt')
  .strip()
  .split(",")
  .collect {|x| x.to_i}

A[1] = 12
A[2] = 2

index = 0
while A[index] != 99
  if A[index] == 1
    A[A[index+3]] = A[A[index+1]] + A[A[index+2]]
  else
    A[A[index+3]] = A[A[index+1]] * A[A[index+2]]
  end
  index += 4
end

puts A[0]
