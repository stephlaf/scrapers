require 'open-uri'
require 'nokogiri'
require 'csv'
require 'pry-byebug'

url = "http://www.noblessence.com/fr/produits/matieres-premieres/c245275/c246196/index.html"

micas_real_names = []

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
      micas_real_names << element.attributes["href"].value.split("/").last.split(".").first
      # he_hash[text] = he_name
      

      # micas_real_names << he_hash
    end
    # p micas_real_names

  end
rescue
  puts "error"
end

file = '/Users/Laf1BUp/Dropbox/Documents/Noblessence/Noblessence_Ressources_Site_web/Data_votresite/To_import/products-stripped-micas.csv'

CSV.open(file, 'wb') do |csv|
  micas_real_names.each do |name|
    csv << [name]
  end
end






