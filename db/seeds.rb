# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

puts "open and read url api"
url = 'http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
buffer = open(url).read
result = JSON.parse(buffer)
result = result["drinks"].sample(15)

puts 'Cleaning database...'
Ingredient.destroy_all

puts "create 15 ingredients"
result.each do |drink|
  Ingredient.create!(name: drink["strIngredient1"])
end

puts "finished"

puts "open and read url api"
url = 'http://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'
buff = open(url).read
result_d = JSON.parse(buff)
result_d = result_d["drinks"].sample(15)

puts 'Cleaning database...'
Cocktail.destroy_all

puts "create 15 cocktails"
result_d.each do |drink|
  Cocktail.create!(name: drink["strDrink"], picture: "https://#{drink['strDrinkThumb']}")
end

puts "finished"
