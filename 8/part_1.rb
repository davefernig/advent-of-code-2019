# The image you received is 25 pixels wide and 6 pixels tall.
# 
# To make sure the image wasn't corrupted during transmission,
# the Elves would like you to find the layer that contains the
# fewest 0 digits. On that layer, what is the number of 1
# digits multiplied by the number of 2 digits?

img = File.read('input.txt').strip().split("").collect { |c| c.to_i }
width = 25
height = 6

#img = "123456789012".split("").collect { |c| c.to_i }
#width = 3
#height = 2

area = width * height
num_layers = img.size / area

zero_counts_to_metric = {}

for i in 0...num_layers
  layer = img[(area*i)...(area+(area*i))]
  num_zeros = (layer.select {|x| x==0}).size
  zero_counts_to_metric[num_zeros] = (layer.select {|x| x==1}).size * (layer.select {|x| x==2}).size
end

puts zero_counts_to_metric
puts zero_counts_to_metric[zero_counts_to_metric.keys.min]
