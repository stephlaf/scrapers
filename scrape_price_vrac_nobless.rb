require 'open-uri'
require 'nokogiri'
require 'csv'
require 'pry-byebug'

def get_prices_and_formats

  filepath = '/Users/Laf1BUp/Dropbox/Documents/Noblessence/Noblessence_Ressources_Site_web/Data_votresite/To_import/products-stripped-vrac-nobless.csv'

  csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
  CSV.foreach(filepath) do |row|
    r = row[0]
    data = []

    # url = "http://www.noblessence.com/fr/produits/produits-aromatherapie/Huiles_essentielles/#{r}.html"
    url = "http://www.noblessence.com/fr/produits/c378161808/c378161851/#{r}.html"

    begin
      html_file = open(url).read
      if html_file
        html_doc = Nokogiri::HTML(html_file)
        class_name = "input2"

        vrac_nobless_name = html_doc.xpath('//*[@id="item_desc2"]/h2').children.text

        #get formats and associated prices
        html_doc.xpath("//*[@class=\"#{class_name}\"]").each do |item|
          format_and_price = item.children.text.strip.gsub(/[CAD$+()]/, "").split
          
          #get individual format-price pairs
          format_and_price.each_with_index do |f_p, i|
            f_ps = {}
            list = {}

            d = f_p.scan(/\w+/)
            format = d[0]
            price = (d[1]+'.'+ d[2]).to_f

          #store vars to hash
            list[:name] = vrac_nobless_name
            list[:url] = r
            list[:format] = format
            list[:price] = price

            data.push(list)
          end

          #pass array as arg to csv method
          write_to_csv(data)

        end
      end
    rescue
      # write error to csv
      data.push(vrac_nobless_name)
      write_to_csv(data)
    end
  end
end


def write_to_csv(data)
  file = '/Users/Laf1BUp/Dropbox/Documents/Noblessence/Noblessence_Ressources_Site_web/Data_votresite/To_import/vrac-nobless-data.csv'

  # CSV.open(file, 'a', write_headers: true, headers: ['Name', 'Url', 'Format', 'Price']) do |csv|
  CSV.open(file, 'a') do |csv|
    # csv << ['Name', 'Url', 'Format', 'Price']
    data.each do |item|
        if item.class == String || item[-1].class == String 
          hash = {}
          hash[:name] = item
          csv << hash.values
        else
          csv << item.values
        end
    end
  end
end

get_prices_and_formats
