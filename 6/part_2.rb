require 'Set'


data = []
File.open("./input.txt", "r") do |f|
  f.each_line do |line|
    data += [line.strip().split(")")]
  end
end

test_data = [
  ["COM", "B"],
  ["B", "C"],
  ["C", "D"],
  ["D", "E"],
  ["E", "F"],
  ["B", "G"],
  ["G", "H"],
  ["D", "I"],
  ["E", "J"],
  ["J", "K"],
  ["K", "L"],
  ["K", "YOU"],
  ["I", "SAN"],
]

def get_path(src, dst, data, acc=[])
  if src == dst
    return acc
  end

  children = Set[]
  for item in data
    if item[0] == src 
      children.add item
    end
  end

  results = []
  if children.size > 0
    new_data = data.select { |item| !children.member? item }
    for child in children
      results += [get_path(child[1], dst, new_data, acc + [src])]
    end
    return results.any? ? (results.select{|x| x})[0] : nil
  end
end

path_to_san = get_path("COM", "SAN", data)
path_to_you = get_path("COM", "YOU", data)

index = 0
while path_to_san[index] == path_to_you[index]
  index += 1
end

puts (path_to_san.size + path_to_you.size) - (2*index)
