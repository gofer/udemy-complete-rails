require 'bcrypt'

my_password = BCrypt::Password.create("my password")
puts my_password.version
puts my_password.cost
p my_password == "my password"
p my_password == "not my password"
