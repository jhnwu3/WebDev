# frozen_string_literal: true

require_relative 'scraper'
require_relative 'calc'
require_relative 'process'
require_relative 'display'

display = Display.new # display class
display.intro # display the intro
microcenter = Scraper.new # Scraper Object to get items
products = microcenter.get_products # Get the products
display.products_analysis(products) # perform analysis
display.brand_analysis(products) # do brand analysis
