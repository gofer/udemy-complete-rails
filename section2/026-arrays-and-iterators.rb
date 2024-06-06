a = [1, 2, 3, 4, 5, 6, 7, 8, 9]
puts a
print a
p a

p a.last

x = 1..100
p x
p x.class
p x.to_a
p x.to_a.shuffle


x = (1..10).to_a
p x
p x.reverse

p x
p x.reverse!
p x

x = "a".."z"
p x
p x.to_a
p x.to_a.shuffle
p x.to_a.length

a = [1, 2, 3, 4, 5, 6, 7, 8, 9]
a << 10
p a
p a.last
p a.first

a = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
a.unshift("Mashrur")
p a
a.append("Mashrur")
p a

a = ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, "Mashrur"]
p a
p a.uniq
p a.uniq!
p a

a = ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
p a.empty?
b = []
p b.empty?

a = ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
p a.include?("Mashrur")
p a.include?("Hossain")

a = ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
p a.push("new item")
p a.pop
p a

a = ["Mashrur", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
p a.join
p a.join("-")
p a.join(", ")

b = a.join("-")
p b.split
p b.split("-")

p %w(my name is mashrur and this is great Ruby is amazing)

z = %w(my name is mashrur and this is great Ruby is amazing)
for i in z
  print i + " "
end
puts

z.each do |food|
  print food + " "
end
puts

z.each {|food| print food + " "}
puts

z.each {|food| print food.capitalize + " "}
puts

z = (1..100).to_a.shuffle
p z
p z.select {|number| number.odd?}
