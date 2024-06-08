dial_book = {
  "newyork" => "212",
  "newbrunswick" => "732",
  "edison" => "908",
  "plainsboro" => "609",
  "sanfrancisco" => "301",
  "miami" => "305",
  "paloalto" => "650",
  "evanston" => "847",
  "orlando" => "407",
  "lancaster" => "717"
}

# Get city names from the hash
def get_city_names(somehash)
  somehash.keys
end

# Get area cide based on given hash and key
def get_area_code(somehash, key)
  somehash[key]
end

# Execution flow
loop do
  # Write code here
  puts "Do you want to lookup an area code based on a city name?(Y/N)"
  answer = gets.chomp.downcase
  break if answer != "y"

  puts "Which city do you want the area code for?"
  get_city_names(dial_book).each { |city_name| puts city_name }
  city = gets.chomp.downcase
  area_code = get_area_code(dial_book, city)
  puts "The area cide for #{city} is #{area_code}"
end
