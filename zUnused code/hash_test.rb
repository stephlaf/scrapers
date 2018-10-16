require 'pry-byebug'
require 'open-uri'
require 'nokogiri'
require 'csv'

def test
  array_a = ["a 0 A", "b 1 B", "c 2 C"]
  array_b = []
  array_c = []
  hash_b = {}

  array_a.each_with_index do |x, i|
    hash_a = {}
    d = x.scan(/\w+/)

    format = d[0]
    price =  d[1]+','+ d[2]

    p d
    p format
    p price

    # hash_a[:name] = d
    hash_a[:format] = format
    hash_a[:price] = price

    array_b.push(hash_a)
  # binding.pry
  p hash_a
  # p array_b
  end
  # binding.pry
  p array_b
end

# test

def test_2
  array_a = ['a', 'b', 'c']
  array_b = []

  array_a.each do |x|
  hash_a = {}
    
    hash_a[:key] = x
    

    p x
    array_b.push(hash_a)
  end
    p array_b
    # p hash_a

end

# test_2

# a = ["a", 1, {}]
# arr = []
# a.each do |x|
#   if x.class == String
#     arr << x
#   else
#     arr << "Nope"
#   end
# end
# p arr

def test
  array_a = ["a 0 A", "b 1 B", "c 2 C"]
  array_b = []

  array_a.each do |x|
    if x.include? "a"
      array_b.push(x)
    else
      array_b.push(x+"A")
    end
    # puts array_b
  end
    # puts array_b
    csv(array_b)
end
  
def csv(data)
  file = '/Users/Laf1BUp/Dropbox/Documents/Noblessence/Noblessence_Ressources_Site_web/Data_votresite/To_import/test.csv'

  CSV.open(file, 'a') do |csv|
    data.each do |he|
        # if he.class == String || he[-1].class == String 
        if he.class == String
          hash = {}
          hash[:name] = he
          csv << hash.values
          binding.pry
        else
          csv << he.values
        end
    end
  end
end

test













