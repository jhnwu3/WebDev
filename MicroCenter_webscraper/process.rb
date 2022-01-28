# frozen_string_literal: true

require_relative 'scraper'

# Processing Class with functions to split all data into a hash of scores with their respective products and brand groupings.
class Processing
  # constructor
  def initialize; end

  # calculates GPU score from spec of name of item
  def gpu_score(title)
    score = 0
    if title.include? '3080'
      score = 4
    elsif title.include?('3070') || title.include?('2080')
      score = 3
    elsif title.include?('3060') || title.include?('2070')
      score = 2
    elsif title.include?('2060') || title.include?('1660')
      score = 1
    end
    score
  end

  # calculates storage score from spec of item name
  def storage_score(title)
    score = 0
    if title.include?('2TB')
      score = 4
    elsif title.include?('1TB')
      score = 3
    elsif title.include?('512GB')
      score = 2
    elsif title.include?('256GB')
      score = 1
    end
    score
  end

  # calculates RAM score from ram spec of item name
  def ram_score(title)
    score = 0
    if title.include?('64GB')
      score = 4 unless title.include?('64GB eMMC Storage') # check to make sure it's not eMMC storage
    elsif title.include?('32GB')
      score = 3 unless title.include?('32GB eMMC Storage')
    elsif title.include?('16GB')
      score = 2 unless title.include?('16GB Flash Drive') # outlier make sure to not read in flash drive as ram.
    elsif title.include?('8GB')
      score = 1
    end
    score
  end

  # calculates CPU score from ram spec of item name
  def cpu_score(title)
    score = 0
    if title.include?('i9') || title.include?('Ryzen 9') || title.include?('M1')
      score = 4
    elsif title.include?('i7') || title.include?('Ryzen 7')
      score = 3
    elsif title.include?('i5') || title.include?('Ryzen 5')
      score = 2
    elsif title.include?('i3') || title.include?('Ryzen 3')
      score = 1
    end
    score
  end

  # Calculates overall laptop_score for process
  def laptop_score(title)
    100 * (gpu_score(title) + cpu_score(title) + ram_score(title) + storage_score(title))
  end

  # brand is a string representing a respective brand
  # returns a list of all products in a specific brand (k: name, V: value)
  def form_brand(brand, products)
    brand_list = []
    products.each do |item|
      brand_list.append(item) unless item.brand != brand
    end
    brand_list
  end

  # takes in products list
  # returns hash of key : brand_set and value: list of all products inside brand
  def all_brands(products)
    brands_set = ['HP', 'Dell', 'Lenovo', 'Microsoft', 'Acer', 'ASUS', 'Apple', 'MSI', 'Samsung', 'LG', 'Razer', 'MAINGEAR', 'Gigabyte', 'Google']
    brands_hash = {}

    brands_set.each do |brand|
      brands_hash[brand] = form_brand(brand, products)
    end
    brands_hash
  end

  # returns a mapping of each product to their respective score.
  def score(products)
    scores = {}
    products.each do |item|
      scores[item] = laptop_score(item.name)
    end
    scores
  end
end
