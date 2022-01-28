# **Mcdonald Project3 - Web Scraping**
In this project, we are going to scrape the information from the [Micro Center](https://www.microcenter.com/search/search_results.aspx?N=4294967288&NTK=all&sortby=match&rpp=96). Then calculate and print out the average price, most expensive laptop, least expensive laptop, best brand value item and its score for each brand according to the scoring mechanism. 

## *Scoring Mechanism*
  - Each spec of a laptop will be ranked as below:
  
       | score|GPU     |CPU                |RAM   |Storage|
       |------|--------|-------------------|------|-------|
       | 400| 3080       |Ryzen 9 / i9 / M1|64GB  | 2TB|
       | 300| 3070 / 2080|Ryzen 7 / i7     |32GB  | 1TB|
       | 200| 3060 / 2070|Ryzen 5 / i5     |16GB  | 512GB|
       | 100| 2060 / 1660|Ryzen 3 / i3     |8GB   | 256GB|
       |   0| All else   | All else   | All else   | All else   |

  

  - Then, it computes an overall laptop spec score by: 
    
        Laptop Score = GPU + CPU + RAM + STORAGE
    
  - To get the score index that we use to rank each laptop, we do: 
  
        Score index = laptop score / price


## **Requirement**
To setup, please first clone all game files using:

    git clone https://github.com/cse3901-2021au-giles/mcdonalds-project3.git

To get all dependencies required for the project, please install these gems into your command line before running: 

    bundle install

To start the scraping, please run in your command line:

    ruby main.rb
    
## **Assumption**

**Micro Center must be up for scraper to work!**  
(Micro Center's website may temporarily go down from time to time)

## **Introduction**  
  This program prints out the best value laptops for every brand as well as the overall best value laptop from microcenter.
### *scraper.rb*
  - scrapes information of the laptops from the website.
    - product class has the initialize function to initialize product's attributes(name, price, brand, link).
    - scraper class scrapes all the products infomation from the website and generate an array of products.

### *calc.rb*
  - calc class contains the calculation of the products
    - average_price() calculates the average price of the elements in the array of product_list
    - score_over_price() return score / product.price
    - find_max_price() finds most expensive item among list of products
    - find_min_price() finds smallest priced item among list of products
    - find_max() returns the max score and product.

### *process.rb*
  - contains functions to split all data into a hash of scores with their respective products and brand groupings.
    - gpu_score() calculates GPU score from spec of name of item
    - storage_score() calculates storage score from spec of item name
    - ram_score() calculates RAM score from ram spec of item name
    - cpu_score() calculates CPU score from ram spec of item name
    - laptop_score() calculates overall laptop_score for process
    - form_brand() returns a list of all products in a specific brand (k: name, V: value)
    - all_brands() returns hash of key : brand_set and value: list of all products inside brand
    - score() returns a mapping of each product to their respective score.
   
### *display.rb*
  - contains all necessary print methods to display analysis' provided by webscraper.
    - brand_analysis() prints out all all the analysis
    - products_analysis() prints overall best value laptops computed from our system

 
## **Testing**

To effectively test each unit test case, please start by entering test folder in terminal:

    cd test

Then, to test each respective file's lower-level functions (unit tests), run each respective test file. For instance, to test calc.rb, we run:

    ruby test_calc.rb

