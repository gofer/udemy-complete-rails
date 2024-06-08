class Student
  attr_accessor :first_name, :last_name, :email
  attr_reader :username

  @first_name
  @last_name
  @email
  @username
  @password

  # def first_name=(name)
  #   @first_name = name
  # end

  # def first_name
  #   @first_name
  # end

  def set_username
    @username = "mashrur1"
  end

  def to_s
    "First name: #{@first_name}"
  end
end

mashrur = Student.new
puts mashrur

mashrur.first_name = "Mashrur"
mashrur.last_name = "Hossain"
mashrur.email = "mashrur@example.com"
# mashrur.username = "mashrur1"
mashrur.set_username
puts mashrur.first_name
puts mashrur.last_name
puts mashrur.email
puts mashrur.username

################################################################################

class Student
  attr_accessor :first_name, :last_name, :email
  attr_reader :username

  @first_name
  @last_name
  @email
  @username
  @password

  def initialize(firstname, lastname, email, username, password)
    @first_name = firstname
    @last_name = lastname
    @email = email
    @username = username
    @password = password
  end

  def to_s
    "First name: #{@first_name}, Last name: #{@last_name}, Email address: #{@email}, Username: #{@username}"
  end
end

mashrur = Student.new("Mashrur", "Hossain", "mashrur@example.com", "mashrur1", "password1")
john = Student.new("John", "Doe", "john1@example.com", "john1", "password2")

puts mashrur
puts john

mashrur.last_name = john.last_name
puts "Mashrur is altered"
puts mashrur
