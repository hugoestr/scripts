# /usr/bin/ruby env
# Will select strings, replace them with randomize strings in size and length


def random_word
  letters = ('a'..'z').to_a
  word = []
  length = (rand 15) + 1
  
  length.times do
    word << letters[rand(25)] 
  end

  word.join ''
end


def replace_names(file_name)
  file = File.open(file_name, "r")
  pattern = /[a-zA-Z]+/

  file.each do |line|
    result = line.gsub pattern, random_word
    puts result
  end
end


replace_names ARGV[0]
