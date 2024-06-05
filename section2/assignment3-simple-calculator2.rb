# Assignment3: `simple-calculator2.rb`

def multiply(first_num, second_num)
  first_num.to_f * second_num.to_f
end

def divide(first_num, second_num)
  first_num.to_f / second_num.to_f
end

def subtract(first_num, second_num)
  second_num.to_f - first_num.to_f
end

def add(first_num, second_num)
  first_num.to_f + second_num.to_f
end

def mod(first_num, second_num)
  first_num.to_f % second_num.to_f
end

puts "Simple calculator"
20.times { print "-" }
puts
puts "Please enter your first number"
first_number = gets.chomp
puts "Please enter your second number"
second_number = gets.chomp
puts "What do you want to do?"
puts "Enter 1 for multiply, 2 for addition, 3 for subtraction"
user_entry = gets.chomp
if user_entry == "1"
  puts "The first number multiplied by the second number is: #{multiply(first_number, second_number)}"
elsif user_entry == "2"
  puts "The first number added to the second number is #{add(first_number, second_number)}"
elsif user_entry == "3"
  puts "The first number subtracted from the second number is #{subtract(first_number, second_number)}"
else
  puts "Invalid entry"
end
