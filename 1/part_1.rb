result = 0
File.open("./input.txt", "r") do |f|
  f.each_line do |line|
    result += (line.to_i / 3) - 2
  end
end
puts result
