begin
   file = open("/Users/Laf1BUp/Dropbox/Documents/Noblessence/Noblessence_Ressources_Site_web/noblessence_images/Images/Category/245218.jpg")
   if file
      puts "File opened successfully"
   end
rescue
      file = STDIN
end
print file, "==", STDIN, "\n"
