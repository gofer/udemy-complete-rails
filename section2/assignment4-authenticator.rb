users = [
  { username: "mashrur",    password: "password1" },
  { username: "jack",       password: "password2" },
  { username: "arya",       password: "password3" },
  { username: "jonshow",    password: "password4" },
  { username: "heisenberg", password: "password5" }
]

puts "Welcome to the authenticator"
25.times { print "-" }
puts
puts "This program will take input from the user and compare password"
puts "If password is correct, you will get back the user object"

# We will learn
# Hash, Array, Branching, While loops and designing program execution flow

try_count = 0
while try_count < 3
  print "Username: "
  username = gets.chomp
  print "Password: "
  password = gets.chomp

  finded_user = users.select {|user| user[:username] == username && user[:password] == password}
  if finded_user.empty?
    puts "Credentials were not correct"
  else
    p finded_user
  end

  try_count += 1
  if try_count == 3
    puts "You have exceeded the number attempts"
    break
  end

  print "Press n to quit or any other key to continue:"
  key = gets.chomp
  break if key == "n"
end
