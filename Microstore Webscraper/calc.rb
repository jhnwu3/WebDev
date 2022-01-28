# frozen_string_literal: true

require_relative 'scraper'
require_relative 'process'

# Calc class
#    methods
#      average_price -> computes average price of a product_list
#      score_over_price -> calculates specific index of laptop price to scoring ratio
#      find_max -> finds max score_index value and product.
class Calc
  # constructor
  def initialize; end

  # calculates the average price of the elements in the array of product_list
  def average_price(product_list)
    sum = 0
    product_list.each do |item|
      sum += item.price
    end
    sum / product_list.length unless product_list.length <= 0 # no divide by 0 or negative
  end

  # return score / product.price
  def score_over_price(score, product)
    divided = 0
    divided = score / product.price unless product.price <= 0 # no divide by <= 0
    divided
  end

  # finds most expensive item among list of products
  def find_max_price(products)
    max_price = products[0].price
    max_item = products[0]
    products.each do |product|
      if product.price > max_price
        max_price = product.price
        max_item = product
      end
    end
    max_item
  end

  # finds smallest priced item among list of products
  def find_min_price(products)
    min_price = products[0].price
    min_item = products[0]
    products.each do |product|
      if product.price < min_price
        min_price = product.price
        min_item = product
      end
    end
    min_item
  end

  # takes in a hash with each product and their respective scores
  # returns the max score and product.
  def find_max(product_scores)
    max_score = 0
    max = ''
    product_scores.each do |product, score|
      score_index = score_over_price(score, product)
      if score_index > max_score
        max = product
        max_score = score_index
      end
    end
    [max, max_score]
  end
end
