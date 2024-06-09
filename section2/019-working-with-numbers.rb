puts 1 + 2

p 10 / 2

p 10 / 4

p 10.0 / 4

p 10 / 4.0

p 10 / 4.to_f

p (10 / 4).to_f

x = 5
y = 10
puts y / x

# "5" * "5"
# => TypeError

p "5" * 2

# p 2 * "5"
# => TypeError

puts "-" * 20
20.times{ print "-" }

20.times{ puts rand(10) }
