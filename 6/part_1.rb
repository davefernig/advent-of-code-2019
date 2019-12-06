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
]

# Shameful, I know. Sue me.
$TOTAL = 0

def get_paths(src, data, acc)
  children = Set[]
  for item in data
    if item[0] == src 
      children.add item
    end
  end

  $TOTAL += acc

  if children.size > 0
    new_data = data.select { |item| !children.member? item }
    for child in children
      get_paths(child[1], new_data, 1 + acc)
    end
  end
end

get_paths("COM", data, 0)
puts $TOTAL
