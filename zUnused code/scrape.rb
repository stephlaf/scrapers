require 'open-uri'
require 'nokogiri'
require 'csv'
require 'pry-byebug'


filepath = '/Users/Laf1BUp/Dropbox/Documents/Noblessence/Noblessence_Ressources_Site_web/Data_votresite/To_import/products-stripped.csv'


csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
CSV.foreach(filepath) do |row|
  r = row[0]

  if r.start_with?('HE ')
    a = r.gsub("HE ", "Huile_essentielle_")
    # b = a.gsub(" ", "_")
    c = a.gsub(/[à, è, é, î, ò, ù, ô, ']/, 'à' => 'a', 'è' => 'e', 'é' => 'e', 'î' => 'i', 'ò' => 'o', 'ù' => 'u', 'ô' => 'o', '\'' => '_')
    # p c
# binding.pry

    url = "http://www.noblessence.com/fr/produits/produits-aromatherapie/Huiles_essentielles/#{c}.html"
    begin
      html_file = open(url).read
      if html_file

        html_doc = Nokogiri::HTML(html_file)

        html_doc.search('//*[@id="item_desc2"]/p/text()[1]').each do |element|
          p c
          puts element.text.strip

          csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
          file = '/Users/Laf1BUp/Dropbox/Documents/Noblessence/Noblessence_Ressources_Site_web/Data_votresite/To_import/products-stripped.csv'

          CSV.open(file, 'wb', csv_options) do |csv|
            csv << [c]
          binding.pry
            
          end

        end
      end
    rescue
      puts "error >> #{c}"
    end
  end
end



csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
file = '/Users/Laf1BUp/Dropbox/Documents/Noblessence/Noblessence_Ressources_Site_web/Data_votresite/To_import/products-stripped.csv'

CSV.open(file, 'wb', csv_options) do |csv|
  csv << [c]
binding.pry

end

