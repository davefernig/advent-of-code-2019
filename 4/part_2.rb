def is_valid(s, acc='', previous=-1, seen_decrease=false, seen_repitition=false)

  if s == ''
    if acc.size == 2
      seen_repitition = true
    end
    return !seen_decrease && seen_repitition
  end

  if s[0].to_i < previous
    seen_decrease = true
  elsif s[0].to_i == previous
    acc += acc.size == 0 ? s[0] + s[0] : s[0]
  else
    if acc.size == 2
      seen_repitition = true
    end
    acc = ''
  end

  is_valid(
    s[1..-1],
    acc=acc,
    previous=s[0].to_i,
    seen_decrease=seen_decrease,
    seen_repitition=seen_repitition
  )
end

count = 0

for i in 357253..892942
  if is_valid i.to_s
    count += 1
  end
end

puts count
