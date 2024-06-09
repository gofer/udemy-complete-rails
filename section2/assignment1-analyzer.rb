# Assignment1: `analyzer.rb`

puts 'What is your first name?'
first_name = gets.chomp
puts 'What is your last name?'
last_name = gets.chomp

full_name = first_name + ' ' + last_name
puts "Your full name is #{full_name}"
puts "Your full name reversed is #{full_name.reverse}"

full_name_length = first_name.length + last_name.length
# full_name_length = full_name.length - 1
puts "Your name has #{full_name_length} characters in it"
