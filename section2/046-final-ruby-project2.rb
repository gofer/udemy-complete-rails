require 'bcrypt'

# my_password = BCrypt::Password.create("my password")
# puts my_password

my_password = BCrypt::Password.new("$2a$12$ggov39INEPTuKAMzZscRleoAaiDCeiTdaUdp3KFgbyOXEZvsL0JvW")
puts my_password
p my_password == "my password"

my_password_1 = BCrypt::Password.create("my password")
my_password_2 = BCrypt::Password.create("my password")
puts my_password
puts my_password_1
puts my_password_2

p my_password == my_password_1
p my_password_1 == "my password"


users = [
  { username: "mashrur",    password: "password1" },
  { username: "jack",       password: "password2" },
  { username: "arya",       password: "password3" },
  { username: "jonshow",    password: "password4" },
  { username: "heisenberg", password: "password5" }
]

def create_hash_digest(password)
  BCrypt::Password.create(password)
end

def verify_hash_digest(password)
  BCrypt::Password.new(password)
end

new_password = create_hash_digest("password1")

puts new_password == "password2"

def create_secure_users(list_of_users)
  list_of_users.each do |user_record|
    user_record[:password] = create_hash_digest(user_record[:password])
  end
  list_of_users
end

puts create_secure_users(users)
