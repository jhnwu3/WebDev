# **Mcdonalds Project 5 -The Game of Set,Reload**

Welcome to the Game of Set - McDonald's Edition  
Let's start off with some basic instructions of the game below: 
[Game Manual](https://www.setgame.com/sites/default/files/instructions/SET%20INSTRUCTIONS%20-%20ENGLISH.pdf)

## **Basic Rules** 

The objective of the game is to identify a SET of 3 cards from 12 cards placed faced up on the table.   
Each card has 4 attrubutes, which are the following: 

|Shape      |Numbers                  |Shadings    |Colors        |   
|-----------|-------------------------|------------|--------------|
|diamond, squiggle, oval |one,two,three|solid, striped, open |red, purple, green|

   
for example, all the cards will be displayed as below:   
<img width="451" alt="Screen Shot 2021-11-04 at 23 58 56" src="https://user-images.githubusercontent.com/70242213/140456081-79f2d566-fd79-423d-b9a5-0b1d92839ae2.png">



A SET consists of 3 cards in which each of the cards' features, looked at one-by-one, are the same on each card, or, are different on each card. All of the features must seperately satisfy this rule. In other words: shape must be either the same on all 3 cards, or different on each of the 3 cards; color must be either the same on all 3 cards, or different on each of the 3, etc. 

## **Introduction**
First, clone the repo:

    git clone https://github.com/cse3901-2021au-giles/mcdonalds-project5.git

Then, click on the index.html to go to the home page of the game. Then, click on "Play Game" to start the game. If you need help, please make sure to click on the instructions before you begin.

### *game.js*
  - game.js include all the game functions.
### *game.html*
  - game.html is the page to access the game.
    -the player's name and score will be placed on the left side.
### *index.html*
  - index.html is the home page of the game.
    - Click on "Play Game" the enter the game.html to play the game.
    - Click on "Introduction" to see the intriduction of the game.
    - Click on "Quit Game" to quit the game.
### *introduction.html*
-introduction.html includes the introduction of the game of the set.
### *style.css*
- style.css include all the styling of the html pages.

## **Testing**
To get started do:

    bundle install

To start testing, make sure to change each path in each browser.goto function to the respective html files in your cloned repository, there are currently filler paths shown as:

    "file:///C:/Users/16142/Downloads/mcdonalds-project5-main/mcdonalds-project5-main/game.html"

Do not remove the file:// prefix as that is extremely vital to proper testing function. Then, run:

    ruby testing.rb

to begin testing basic methods using watir.