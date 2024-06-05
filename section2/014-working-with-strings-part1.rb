# String concatenation
# sentence = "My name is Mashrur"
sentence = 'My name is Mashrur'
p sentence

first_name = "Mashrur"
last_name = "Hossanin"

puts first_name + last_name
puts first_name + " " + last_name
puts "My first name is #{first_name} and my last name is #{last_name}"
puts 'My first name is #{first_name} and my last name is #{last_name}'

p "Mashrur".class

p 10.class

p 10.0.class

p "Mashrur".methods

p 10.class
p 10.to_s.class

p "Mashrur".length
p "Mashrur".reverse
p "Mashrur".capitalize

p "Mashrur".empty?
p "".empty?

p "".nil?
p nil.nil?

sentence = "Welcome to the jungle"
p sentence
p sentence.sub("the jungle", "utopia")

new_first_name = first_name
p new_first_name

first_name = "John"
p new_first_name

p 'the new first name is #{new_first_name}'

p "the new first name is \#{new_first_name}"

# 'Mashrur aske 'Hey John, how are you doing?''

p 'Mashrur aske \'Hey John, how are you doing?\''
