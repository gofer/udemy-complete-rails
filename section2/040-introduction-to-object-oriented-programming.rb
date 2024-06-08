class Student
  @first_name
  @last_name
  @email
  @username
  @password

  def to_s
    "First name: #{@first_name}"
  end
end

mashrur = Student.new
puts mashrur

# mashrur.first_name = "Mashrur"
puts mashrur

class Course
end
