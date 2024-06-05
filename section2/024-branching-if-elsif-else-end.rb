if true
  puts "Hello"
end


if true
  puts "Hello"
else
  puts "Bye"
end


if true
  puts "Hello"
else
  puts "Bye"
end
puts "La la la"


condition = false
if condition
  puts "Hello"
else
  puts "Bye"
end
puts "La la la"


condition = true
if condition
  puts "Hello"
else
  puts "Bye"
end
puts "La la la"


condition = true
another_condition = true
if condition && another_condition
  puts "Hello"
else
  puts "Bye"
end
puts "La la la"


condition = true
another_condition = false
if condition && another_condition
  puts "Hello"
else
  puts "Bye"
end
puts "La la la"


condition = true
another_condition = false
if condition || another_condition
  puts "this evaluated to true"
else
  puts "this evaluated to false"
end
puts "La la la"


condition = false
another_condition = false
if condition || another_condition
  puts "this evaluated to true"
else
  puts "this evaluated to false"
end
puts "La la la"


condition = false
another_condition = false
if !condition && !another_condition
  puts "this evaluated to true"
else
  puts "this evaluated to false"
end
puts "La la la"


condition = false
another_condition = false
if !condition || !another_condition
  puts "this evaluated to true"
else
  puts "this evaluated to false"
end
puts "La la la"


condition = false
another_condition = false
if !condition || another_condition
  puts "this evaluated to true"
else
  puts "this evaluated to false"
end
puts "La la la"


condition = false
another_condition = false
if (!condition || another_condition)
  puts "this evaluated to true"
else
  puts "this evaluated to false"
end
puts "La la la"


name = "Mashrur"

if name == "Mashrur"
  puts "Welcome to the program, Mashrur"
elsif name == "Jack"
  puts "Welcome to the program, Jack"
else
  puts "Welcome to the program, User"
end


name = "Jack"

if name == "Mashrur"
  puts "Welcome to the program, Mashrur"
elsif name == "Jack"
  puts "Welcome to the program, Jack"
else
  puts "Welcome to the program, User"
end


name = "Evgeny"

if name == "Mashrur"
  puts "Welcome to the program, Mashrur"
elsif name == "Jack"
  puts "Welcome to the program, Jack"
elsif name == "Evgeny"
  puts "Go back to helping students Evgeny"
else
  puts "Welcome to the program, User"
end
