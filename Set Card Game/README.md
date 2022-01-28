# **Mcdonalds Project 2 - Game of Set**

Welcome to the Game of Set - McDonald's Edition  
Let's start off with some basic instructions of the game below: 
[Game Manual](https://www.setgame.com/sites/default/files/instructions/SET%20INSTRUCTIONS%20-%20ENGLISH.pdf)

## **Basic Rules** 

The objective of the game is to identify a SET of 3 cards from 12 cards placed faced up on the table.   
Each card has 4 attrubutes, which are the following: 

|Shape      |Numbers                  |Shadings    |Colors        |   
|-----------|-------------------------|------------|--------------|
|<>, [], {} |<#>,  <#> <#>,  <#> <#> <#>|\| , + , #  |Red,Green,Blue|
   
for example, all the cards will be displayed as below:   
  ![VirtualBox_Ubuntu_3901_20_09_2021_21_05_05](https://user-images.githubusercontent.com/70242213/134097078-fb5273b1-623e-43b4-ac03-1fc40d1c14cb.png)


A SET consists of 3 cards in which each of the cards' features, looked at one-by-one, are the same on each card, or, are different on each card. All of the features must seperately satisfy this rule. In other words: shape must be either the same on all 3 cards, or different on each of the 3 cards; color must be either the same on all 3 cards, or different on each of the 3, etc. 


+ For two player mode:  
    Each player will get a round to play the game, and who ever gets the highest score between the both of them wins the game.   
    
## **Requirement**
To setup the game, please first clone all game files using:

    git clone https://github.com/cse3901-2021au-giles/mcdonals-project2.git

To get all dependencies required for the game, please install these gems into your command line before running: 

    gem install colorize

To start the game, please run in your command line:

    ruby main.rb

## **Introduction**  
If you're curious about the implementation of this game, here's a rundown of each .rb file:
  
### *board.rb*
- Board class initialized with a deck of cards and the respective number of cards on display.
  - Initialize function
      - initialize deck of 81 unique cards, shuffle the deck, then extract 12 cards from deck to show on board, and remove each card from deck and add to ondisplay.
  - update_board function 
      - update the board of any changes made as well as creates the colorful terminal GUI.
  - add_cards function 
      - adds 3 new cards from deck.
  - remove_cards function 
      - removes the set of 3 cards taken from board.
  - check_cards function 
      - checks if the board has a set on display.

### *player.rb*
  - defines player class with respective name and score values

### *hint_generator.rb*
 - HintGenerator class generates hint for the player if the user is stuck.
    - give_hint function
       - returns tuple pair of digits that correspond to each card in a set. 

### *game.rb*  
  - includes all game functions.
    - initialize function
      - Construct an array of 5 player objects and initialize a new game board.
    - game session function :
      - initializes a game session and setups game rules
    - score function 
      - that computes top 5 scores

### *card.rb*  
  - has all card checker functions that check for if a set of 3 cards is a set.
    - Class Card has the inilialize function to initialize card's attributes.
    - Class CardChecker includes all the card checker functions.  

### *main.rb*  
  - defines main function with user input.
  
## **Testing**
To effectively test each unit test case, please start by entering test folder in terminal:

    cd test
  
Then, to test each respective file's lower-level functions (unit tests), run each respective test file. 
For instance, to test card.rb, we run:
    
    ruby test_card.rb

