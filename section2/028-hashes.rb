sample_hash = {'a' => 1, 'b' => 2, 'c' => 3}
p sample_hash
p sample_hash['b']

my_details = {'name' => 'mashrur', 'favcolor' => 'red'}
p my_details
p my_details['favcolor']

another_hash = {a: 1, b: 2, c: 3}
p another_hash
p another_hash[:a]

p sample_hash.keys
p sample_hash.values

sample_hash.each do |key, value|
  puts "The class for key is #{key.class} and the vlaue is #{value.class}"
end

my_details.each do |key, value|
  puts "The class for key is #{key.class} and the vlaue is #{value.class}"
end

my_details = {:name => 'mashrur', :favcolor => 'red'}
my_details.each do |key, value|
  puts "The class for key is #{key.class} and the vlaue is #{value.class}"
end

myhash = {a: 1, b: 2, c: 3, d: 4}
p myhash
myhash[:e] = "Mashrur"
p myhash
myhash[:c] = "Ruby"
p myhash
myhash.each{|some_key, some_value| puts "The class for key is #{some_key} and the vlaue is #{some_value}"}
p myhash.select {|k, v| v.is_a?(String)}
myhash.each {|k, v| myhash.delete(k) if v.is_a?(String)}
p myhash
