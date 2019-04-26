plutil -replace "here_maps_app_id" -string "your_app_id" ../example/ios/Runner/Info.plist
plutil -replace "here_maps_app_token" -string "your_app_token" ../example/ios/Runner/Info.plist
plutil -replace "here_maps_app_license" -string "your_app_license" ../example/ios/Runner/Info.plist
ruby clean_android_keys_before_commit.rb
