# frozen_string_literal: true

require_relative 'calc'
require_relative 'scraper'
require_relative 'process'

# Display class
# Methods
#   display_brand_analysis - prints each brand with their respective best value item and average prices.
class Display
  # products = products list with tuples of Product(name, brand, price, link )
  # prints out all all the analysis'
  def brand_analysis(products)
    proc = Processing.new
    calc = Calc.new
    all_brands = proc.all_brands(products)
    all_brands.each do |brand, list_of_products|
      products_with_scores = proc.score(list_of_products)
      best_value_item = calc.find_max(products_with_scores)
      # item list can be null if no items exist for said product line.
      puts "-------------------------------------[#{brand}]------------------------------------------------"
      if !list_of_products.nil? && list_of_products.length.positive?
        puts "Average Price: #{calc.average_price(list_of_products).round(2)} $" unless calc.average_price(list_of_products).nil?
        puts "nItems: #{list_of_products.length}"
        puts "Most Expensive Laptop: #{calc.find_max_price(list_of_products).name}"
        puts "Least Expensive Laptop: #{calc.find_min_price(list_of_products).name}"
        puts "*Best Brand Value Item: #{best_value_item[0].name}"
        puts "with score index: #{best_value_item[1].round(3)}"
        puts "with price: #{best_value_item[0].price}"
        puts "\n"
      else 
        puts "N/A"
        puts "\n"
      end
    end
  end

  # Prints overall best value laptops computed from our system
  def products_analysis(products)
    proc = Processing.new
    calc = Calc.new
    products_with_scores = proc.score(products)
    max = calc.find_max(products_with_scores)
    puts "For all #{products.length} products in Microcenter:"
    puts "Average Price of Laptop: #{calc.average_price(products).round(2)} $"
    puts "Most Expensive Laptop: #{calc.find_max_price(products).name}"
    puts "Least Expensive Laptop: #{calc.find_min_price(products).name}"
    puts "*Best Value Laptop: #{max[0].name}"
    puts "With Score Index: #{max[1].round(3)}"
    puts "And Price: #{max[0].price}"
  end

  def intro
    puts '---------------------------------------------------------'
    puts 'Microcenter Scraper:'
    puts 'Check Readme for Scoring System and How We Compute Values!'
    puts 'Now Collecting Data Needed to Find You The Best Laptop!'
    puts '---------------------------------------------------------'
  end
end
