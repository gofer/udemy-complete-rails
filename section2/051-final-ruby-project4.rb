require_relative 'student'

mashrur = Student.new("Mashrur", "Hossain", "mashrur@example.com", "mashrur1", "password1")
john = Student.new("John", "Doe", "john1@example.com", "john1", "password2")

p mashrur

hashed_password = mashrur.create_hash_digest(mashrur.password)
p hashed_password
