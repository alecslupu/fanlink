base_url = ENV["FIREBASE_URL"] || (abort "You need to set FIREBASE_URL")
key = ENV["FIREBASE_KEY"] || (abort "You need to set FIREBASE_KEY")
FIREBASE ||= Firebase::Client.new(base_url, key)
