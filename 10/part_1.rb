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

def distance(p1, p2)
  (p2[0] - p1[0])**2 + (p2[1] - p1[1])**2
end

def aligned?(src, p1, p2)
  atan2_1 = Math.atan2(p1[0] - src[0], p1[1] - src[1])
  atan2_2 = Math.atan2(p2[0] - src[0], p2[1] - src[1])
  atan2_1 == atan2_2
end

def count_visible(space, src_x, src_y)
  visible = []
  outer_search_y = 0
  while outer_search_y < space.size
    outer_search_x = 0
    while outer_search_x < space[0].size
      if space[outer_search_y][outer_search_x] == 1 && (src_x != outer_search_x || src_y != outer_search_y)
        blocked = false
        for v in visible
          if aligned?([src_x, src_y], v, [outer_search_x, outer_search_y])
            blocked = true
            if distance([src_x, src_y], [outer_search_x, outer_search_y]) < distance([src_x, src_y], v)
              visible.delete_if {|x| x == v }
              visible << [outer_search_x, outer_search_y]
            end
          end
        end
        if !blocked
          visible << [outer_search_x, outer_search_y]
        end
      end
      outer_search_x += 1
    end
    outer_search_y += 1
  end
  visible.size
end

position_to_count = {}
outer_search_y = 0
while outer_search_y < height
  outer_search_x = 0
  while outer_search_x < width
    if space[outer_search_y][outer_search_x] == 1
      position_to_count[[outer_search_x, outer_search_y]] = count_visible(
        space,
        outer_search_x,
        outer_search_y,
      )
    end
    outer_search_x += 1
  end
  outer_search_y += 1
end

puts position_to_count.max_by{|k,v| v}
