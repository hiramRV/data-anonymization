#!/usr/bin/env ruby
require 'sqlite3'

# Connect to the database
db = SQLite3::Database.new('sample-data/chinook.sqlite')
#db = SQLite3::Database.new('sample-data/chinook-empty.sqlite')

puts "=== Database Tables ==="
tables = db.execute("SELECT name FROM sqlite_master WHERE type='table';")
tables.each { |table| puts "- #{table[0]}" }

puts "\n=== Customer Table Schema (closest to User) ==="
schema = db.execute("PRAGMA table_info(Customer);")
schema.each do |column|
  puts "#{column[1]} (#{column[2]})"
end

puts "\n=== Sample Customer Data (first 5 rows) ==="
customers = db.execute("SELECT * FROM Customer LIMIT 5;")
customers.each_with_index do |customer, index|
  puts "Row #{index + 1}: #{customer.inspect}"
end

puts "\n=== Customer Count ==="
count = db.execute("SELECT COUNT(*) FROM Customer;")
puts "Total customers: #{count[0][0]}"

db.close
