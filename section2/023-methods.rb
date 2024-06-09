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

puts "Please enter your first number"
first_number = gets.chomp
puts "Please enter your second number"
second_number = gets.chomp
puts "The first number multiplied by the second number is: #{multiply(first_number, second_number)}"
puts "The first number divied by the second number is #{divide(first_number, second_number)}"
puts "The first number subtracted from the second number is #{subtract(first_number, second_number)}"
puts "The first number added to the second number is #{add(first_number, second_number)}"
puts "The first number mod the second number is #{mod(first_number, second_number)}"
