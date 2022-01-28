# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'restclient'
require 'mechanize'

#   Product class used in Scraper class
#     instance variables
#       name, price, brand, link
#     methods
#       constructor and getters/setters

class Product
  # constructor
  def initialize(name, price, brand, link)
    @name = name
    @price = price.to_f
    @brand = brand
    @link = link
  end

  # getters and setters
  attr_accessor :name, :price, :brand, :link
end

# Scraper class
#   instance variable
#     products : array of fetched products, each with price, brand, link, and name
#   methods
#     print_products : prints all products in products array with appropriate formatting

class Scraper
  # constructor
  def initialize
    # products holds Product objects fetched from the doc
    @products = []

    # get the microcenter results page with laptops
    mechanize = Mechanize.new
    url = 'https://www.microcenter.com/search/search_results.aspx?N=4294967288&NTK=all&sortby=match&rpp=96'
    doc = mechanize.get(url)
    # takes the tag text and links with href links to create a hash map
    links_pages_key = doc.search('//nav/ul[@class="pages inline"]/li/a').map(&:text)
    links_pages_value = doc.search('//nav/ul[@class="pages inline"]/li/a/@href').map(&:text)
    links_pages = Hash[links_pages_key.zip links_pages_value]
    # collect product names, prices, brands, and links
    names = doc.search('div.normal h2 a').map(&:text)
    prices = doc.xpath('//div/a/@data-price').collect { |node| node.text.strip }
    brands = doc.xpath('//div/a/@data-brand').collect { |node| node.text.strip }
    links = doc.xpath('//div/h2/a/@href').collect { |node| node.text.strip }

    # initialize @products array using fetched data
    m = 2 # next page count
    links_pages.each do |linkers, values|
      # collect product names, prices, brands, and links
      names = doc.search('div.normal h2 a').map(&:text)
      prices = doc.xpath('//div/a/@data-price').collect { |node| node.text.strip }
      brands = doc.xpath('//div/a/@data-brand').collect { |node| node.text.strip }
      links = doc.xpath('//div/h2/a/@href').collect { |node| node.text.strip }
      # initialize @products array using fetched data
      i = 0
      names.each do |name|
        core_link = 'https://www.microcenter.com'
        @products.append(Product.new(name, prices[i], brands[i], core_link + links[i]))
        i += 1
      end
      if linkers.to_i.equal?(m)
        url = "https://www.microcenter.com#{values}"
        doc = mechanize.get(url)
        m += 1
      else
        break
      end
    end
  end

  # getter
  def get_products
    @products
  end

  # this method prints products in formatte manner
  def print_products
    i = 1
    @products.each do |item|
      puts "-------------------------------------item #{i}---------------------------------------------------------------------"
      puts "Laptop Specs#{item.name}"
      puts "Brand: #{item.brand}"
      puts "Price: $#{item.price}"
      puts "Link to item: #{item.link}"
      i += 1
    end
  end
end
