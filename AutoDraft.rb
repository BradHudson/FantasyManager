require 'pry'
require 'csv'

csv_text = File.read('rankings.csv')
binding.pry
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  binding.pry
  puts row
end