puts "Preparing seeds.\n"

Dir[Rails.root.join('db', 'seeds', '*_seed.rb')].each { |file| require file }

puts 'Seeds were executed :)'
