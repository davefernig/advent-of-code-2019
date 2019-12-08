img = File.read('input.txt').strip().split("").collect { |c| c.to_i }
width = 25
height = 6

area = width * height
num_layers = img.size / area
layers = (0...num_layers).collect {|i| img[(area*i)...(area+(area*i))]}

result = []
for i in 0...area
  j=0
  while layers[j][i] == 2
    j+=1
  end
  result += [layers[j][i]]
end

def pprint(img, width, height)
  for i in 0...height
    row = img[(i*width)...(width+(i*width))]
    puts row.collect {|i| i==0 ? " " : "#"}.join ""
  end
end

pprint(result, width, height)
