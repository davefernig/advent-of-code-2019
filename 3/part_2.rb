data = File
  .read('input.txt')
  .split("\n")

wire1 = data[0].split(",")
wire2 = data[1].split(",")

test_wire1 = "R75,D30,R83,U83,L12,D49,R71,U7,L72".split(",")
test_wire2 = "U62,R66,U55,R34,D71,R55,D58,R83".split(",")

def get_updates(direction, num_steps, pos)
  if direction == "U"
    return (1..num_steps).collect {|i| [pos[0], pos[1] + i]}
  elsif direction == "D"
    return (1..num_steps).collect {|i| [pos[0], pos[1] - i]}
  elsif direction == "L"
    return (1..num_steps).collect {|i| [pos[0] - i, pos[1]]}
  else
    return (1..num_steps).collect {|i| [pos[0] + i, pos[1]]}
  end
end

def get_points_traversed(wire, pos=[0, 0], acc={}, steps=0)
  return acc unless wire != []
  direction = wire[0][0]
  num_steps = wire[0][1..-1].to_i
  updates = get_updates(direction, num_steps, pos)

  updates.collect.with_index {|position, i|
    if acc.member? position
      acc[position] = [
        steps + i + 1,
        acc[position]
      ].min
    else
      acc[position] = steps + i + 1
    end
  }

  get_points_traversed(
    wire[1..-1],
    updates[-1],
    acc,
    steps + num_steps,
  )
end

def get_closest_intersection(wire1, wire2)
  wire1 = get_points_traversed(wire1)
  wire2 = get_points_traversed(wire2)

  intersections = []
  for point in wire1.keys
    if wire2.member? point
      intersections << wire1[point] + wire2[point]
    end
  end
  intersections.min
end

puts get_closest_intersection(test_wire1, test_wire2)
