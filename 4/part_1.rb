def is_valid n
  seen_repitition = false
  seen_decrease = false
  previous = -1
  for char in n.to_s.split ''
    if char.to_i == previous
      seen_repitition = true
    end
    if char.to_i < previous
      seen_decrease = true
    end
    previous = char.to_i
  end
  seen_repitition && !seen_decrease
end

count = 0

for i in 357253..892942
  if is_valid i.to_s
    count += 1
  end
end

puts count
