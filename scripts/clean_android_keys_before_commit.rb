root_dir_path = File.expand_path("../", File.dirname(__FILE__))
strings_file_path = File.expand_path("#{root_dir_path}/example/android/app/src/main/res/values/here_maps_keys.xml", File.dirname(__FILE__))

puts strings_file_path

strings_file = File.read(strings_file_path)

strings_file = strings_file.gsub(/(<string name="appid">).*(<\/string>)/, "\\1{APP_ID}\\2")
strings_file = strings_file.gsub(/(<string name="apptoken">).*(<\/string>)/, "\\1{APP_TOKEN}\\2")
strings_file = strings_file.gsub(/(<string name="license">).*(<\/string>)/, "\\1{LICENSE}\\2")

File.write(strings_file_path, strings_file)