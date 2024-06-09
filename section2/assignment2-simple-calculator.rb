# Assignment2: `simple-calculator.rb`

puts "Simple calculator"
25.times{ print "-" }
puts
puts "Enter the first number"
num_1 = gets.chomp
puts "Enter the second number"
num_2 = gets.chomp
puts "The first number multiplied by the second number is #{num_1.to_f * num_2.to_f}"
puts "The first number divied by the second number is #{num_1.to_f / num_2.to_f}"
puts "The first number subtracted from the second number is #{num_2.to_f - num_1.to_f}"
puts "The first number added to the second number is #{num_2.to_f + num_1.to_f}"
puts "The first number mod the second number is #{num_1.to_i % num_2.to_i}"
