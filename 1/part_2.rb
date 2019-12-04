result = 0

def get_mass(n, acc=0)
  if n <= 0
    return acc
  else
    n = (n / 3) - 2
    return get_mass(n, acc + [n, 0].max)
  end
end

File.open("./input.txt", "r") do |f|
  f.each_line do |line|
    result += get_mass(line.to_i)
  end
end

puts result
