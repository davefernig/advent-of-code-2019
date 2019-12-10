# Test Case
# input = "......#.#.
# #..#.#....
# ..#######.
# .#.#.###..
# .#..#.....
# ..#....#.#
# #..#....#.
# .##.#..###
# ##...#..#.
# .#....####"

# Real input
input = File.read("input.txt")

space = []
for row in input.split("\n")
  space << row.split("").collect { |c| c==="." ? 0 : 1 }
end

height = space.size
width = space[0].size
src = [26, 29]

def distance(p1, p2)
  (p2[0] - p1[0])**2 + (p2[1] - p1[1])**2
end

neighbors = []
y = 0
while y < height
  x = 0
  while x < width
    if space[y][x] == 1 && ([x, y] != src)
      neighbors << [
        [x, y],
        Math.atan2(x - src[0], y - src[1]),
        distance(src, [x, y]),
      ]
    end
    x += 1
  end
  y += 1
end

# Group the asteroids by angle
clusters = {}
for n in neighbors
   # It's late, sue me
  if n[1] >= 0.0
    key = n[1]
  else
    key = 4 + (1.0 / n[1])
  end

  if clusters.member? key
    clusters[key] << n
  else
    clusters[key] = [n]
  end
end

# Sort each group by distance
for i in clusters.keys
  clusters[i].sort_by {|x| x[2]}
end

keys = clusters.keys.sort
puts keys

blasted = 0
while blasted < 200
  next_cluster = keys[blasted % keys.size]
  coords = clusters[next_cluster]
  clusters[next_cluster] = clusters[next_cluster][1..-1]
  blasted += 1
end
puts coords
