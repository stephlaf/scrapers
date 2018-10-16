require 'open-uri'
require 'nokogiri'
require 'csv'
require 'pry-byebug'

url = "http://www.noblessence.com/fr/produits/matieres-premieres/c246197/index.html"

oxyde_real_names = []

begin
  html_file = open(url).read
  if html_file

    html_doc = Nokogiri::HTML(html_file)
    
    li_count = 1
    ul_count = 1

    x_path = '//*[@id="item"]/ul["+ul_count+"]/li["+li_count+"]/form/div[3]/a'
    
    html_doc.search(x_path).each do |element|
      # he_hash = {}
      text = element.text.strip
      oxyde_real_names << element.attributes["href"].value.split("/").last.split(".").first
      # he_hash[text] = he_name
      

      # oxyde_real_names << he_hash
    end
    # p oxyde_real_names

  end
rescue
  puts "error"
end

file = '/Users/Laf1BUp/Dropbox/Documents/Noblessence/Noblessence_Ressources_Site_web/Data_votresite/To_import/products-stripped-oxydes.csv'

CSV.open(file, 'wb') do |csv|
  oxyde_real_names.each do |name|
    csv << [name]
  end
end






