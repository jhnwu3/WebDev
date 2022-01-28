require 'webdrivers'
require 'watir'

browser = Watir:: Browser.new :chrome


#testing buttons on the home page 
browser.goto("file:///C:/Users/16142/Downloads/mcdonalds-project5-main/mcdonalds-project5-main/index.html")
browser.button(:name => "game").click
puts "Test 1 Executes"

browser.goto("file:///C:/Users/16142/Downloads/mcdonalds-project5-main/mcdonalds-project5-main/index.html")
browser.button(:name => "instruction").click
puts "Test 2 Executes"

browser.goto("file:///C:/Users/16142/Downloads/mcdonalds-project5-main/mcdonalds-project5-main/index.html")
browser.button(:name => "quit").click
puts "Test 3 Executes"

#testing if features are available 
browser.goto("file:///C:/Users/16142/Downloads/mcdonalds-project5-main/mcdonalds-project5-main/game.html")
l=b.div class:'left column'
l.exists?
puts 'Test 4 Executes'

#testing if features are available 
browser.goto("file:///C:/Users/16142/Downloads/mcdonalds-project5-main/mcdonalds-project5-main/game.html")
l=b.div class:'center column'
l.exists?
puts 'Test 5 Executes'

browser.close




