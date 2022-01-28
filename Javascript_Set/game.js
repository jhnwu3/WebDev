/*-------------------------------------------------------*/
/* --------------------- Scoreboard Variables------------*/
/*-------------------------------------------------------*/

var players = []; // list of scores to maintain during score keeping session.
var currentUserName; // global variable to keep track of the current user.
var currentUserScore = 0;
var currentUserTime = 0;
var useTimer = true;
class Player {
    constructor(name){
        this.name = name;
        this.score = 0;
        this.timeToFinish = 0;
    }
}

/*-------------------------------------------------------*/
/* ----------------------- Card / Board Vars ------------*/
/*-------------------------------------------------------*/
// deck of remaining cards
var deck = [];
// 12 cards shown on board currently
var on_board = [];
// maximum up to 3 cards chosen by the player
var chosen = [];
/*-------------------------------------------------------*/
/* ------------------------ Card ------------------------*/
/*-------------------------------------------------------*/

const sum = arr => arr.reduce((a,b) => a + b, 0);

function color(card) {  // Card colorings broken up in 1/3rds, first third has red, second third has green etc.
    return Math.floor(card / 27);
}

function number(card) {  // Cards (and respective pic namess) alternate numbers like this in order, 1, 2, 3, 1, 2, 3
    return card % 3;
}

function shape(card) { // Cards have the same shape for every 9 cards (with triplets of course) (only 3 shapes), so card0 ~ card9
    return Math.floor((card % 9) / 3);
}

function shading(card) { // cards have the same shading every 27 cards in 9-tuplets. So observe Card0 has same shading as Card27 and Card8.
    return Math.floor((card % 27) / 9);
}

/* Takes three cards, and returns an array of numbers for each feature where
 
 0 = all the same or all different
 non-zero = two same, one different

*/
function getFeatures(cards) {
    var colors = [];
    var numbers = [];
    var shapes = [];
    var shadings = [];
    for (var feature in cards) {
        colors.push(color(cards[feature]));
        numbers.push(number(cards[feature]));
        shapes.push(shape(cards[feature]));
        shadings.push(shading(cards[feature]));
    }
    return features = [ 
       sum(colors) % 3,
       sum(numbers) % 3,
       sum(shapes) % 3,
       sum(shadings) % 3,
    ];
}

// takes in array of features by features function
function isSet(features) {
    return sum(features) == 0;
}

/*-------------------------------------------------------*/
/* ------------------------ Board / Deck------------------------*/
/*-------------------------------------------------------*/

// fill deck array with 81 unique card numbers - number correspond to its
// actual file name in cards/ subfolder (g.g., 21 means '21.png')
function initializeDeck() {
    // empty deck array
    deck = [];

    // note: can be renamed to match html
    var notification = document.getElementById("notification"); 
    notification.setAttribute("onClick", "");
    notification.innerHTML = "SET";
    notification.style.color = "#bfbfbf";
    
    // push 81 unique card indices to deck
    for (var i = 0; i < 81; i++) {
        deck.push(i);
    }
    // show deck button, and shuffle it
    document.getElementById("deck").style.visibility = "visible";
    shuffleDeck(deck);
}

// shuffle by swapping all individual card (indexes)
function shuffleDeck(deck) {
    for (let i = 0; i < deck.length; i++) {
        // use random integer to compute random index of deck array to swap
        swap = i + Math.floor(Math.random() * (deck.length - i)); 
        // swap
        let tmp = deck[i];
        deck[i] = deck[swap];
        deck[swap] = tmp;
    }
}

// fill in the 4x3 grid on HTML with 12 cards from deck
function dealCards() {
    // get the table
    var grid = document.getElementById("cardsOnTable");
    // fill in each cell with card by poppping from deck
    for (var r = 0; r < 4; r++) {
        for (var c = 0; c < 3; c++) {
            // get the card number
            var card = deck.pop();
            // fill in cell with html img tag
            grid.rows[r].cells[c].innerHTML= '<img src = "cards/'.concat(card.toString(), '.png">');
            // make cell visible
            grid.rows[r].cells[c].style.visibility = "visible";
            // add added card to board
            on_board.push(card);
        }
    }
}

// update remaining number of cards in deck in HTML 
function updateRemCount() {
    document.getElementById("deckCount").innerHTML = "Cards remaining: ".concat(deck.length.toString());
}

// reset board in case there is no set on the board
// if there is a set, display message saying there exist a set already
function dealBoard() {
    // get notification element from HTML
    var notification = document.getElementById("notification");
    notification.style.visibility = "visible";
    // if there's no set on the board
    if (!setExists(on_board)) {
        // put the cards on board back to deck
        deck.push(...on_board);
        // empty board
        on_board = [];
        // shuffle deck and re-deal cards
        shuffleDeck();
        dealCards();        
        // then display notification message
        notification.innerHTML = "New cards on the board";
        notification.style.color = "black";
    } else {
        // otherwise there is a set player has to find - display message
        notification.innerHTML = "There exists a set on current board.";
        notification.style.color = "black";
    }

    // check if there is no more sets left in the whole game
    checkRemaining();
}

// check if there is a set remaining in the game
// if not, tell user to restart game and log final timer
function checkRemaining() {
    // if less than 21 cards remain, there's possibility that there's no set
    if (deck.length + on_board.length < 21) {
        // get all the remaining cards
        var remaining = [];
        remaining.push(...deck);
        remaining.push(...on_board);
        // if 0 sets remain, show message and mark final time
        if (!setExists(remaining)) {
            var notification = document.getElementById("notification");
            notification.style.visibility = "visible";
            notification.innerHTML = "Game finished. Click this message to restart";
            notification.style.color = "green";
            notification.setAttribute("onClick", "startGame()");
            end = timer.innerHTML;
            timer.style.color = "blue";
        }

    }
}

/*---------------------------------------------------------------------------*/
/*------Card selection / replacement upon set completion / check set + update HTML ---*/
/*---------------------------------------------------------------------------*/

// function to handle user input on selecting card
function selectCard(cell, idx) {
    document.getElementById("notification").style.color = "#bfbfbf";
    
    // see if idx is already chosen (in chosen[])
    var card = chosen.indexOf(idx);

    // if card >= 0, that means it has already been chosen
    // hence, deselect instead
    if (card >= 0) {
        chosen.splice(card, 1);
        // reset border color of the card to normal
        cell.style.border = "6px solid #bfbfbf";
    // otherwise card is not selected AND
    // user hasn't already selected 3 cards, select card
    } else if (card < 0 && chosen.length < 3) {
        chosen.push(idx); 
        // update border color of the card to chosen
        cell.style.border = "6px solid black";

        // if this was 3rd choice of user, chekc if it's a set
        if (chosen.length == 3) {
            chosenIsSet();
        } 
    }
}

// function called when user completes a set, creating need to replace those cards
// with cards from the deck (if deck has them)
function replaceCards(idxs) {
    // get logo image that user clicks on to reset board
    var logo = document.getElementById("deck");
    // if deck is not empty
    if (deck.length > 0) {
        // replace the cards in idx with new ones from deck
        for (var i = 0; i < idxs.length; i++) {
            // get a new card
            var new_card = deck.pop();
            // get the appropriate cell from the 4x3 board (table) by 
            // concatting chosen card idx to "cell", which gives us the correct id for the cell in HTML
            var cell = document.getElementById("cell".concat(idxs[i].toString()));

            // replace the removed card with the new card in on_board array
            on_board.splice(idxs[i], 1, new_card) 
            // change the cell HTML to show the new card
            cell.innerHTML = '<img src="cards/'.concat(new_card.toString(), '.png">');
            cell.style.border = "5px solid #bfbfbf";
        }
        // if deck is not empty still, show logo image (resets board onclick)
        logo.style.visibility = (deck.length == 0 ? "hidden" : "visible");
    } else {
        // otherwise, deck is empty!
        // get rid of chosen cards from board 
        for (var i = 0; i < idxs.length; i++) { 
            // get the HTML element with chosen card index
            var cell = document.getElementById("cell".concat(idxs[i].toString()));
            // delete the chosen card from on_board
            on_board.splice(idxs[i], 1, -1) 
            cell.style.border = "5px solid #bfbfbf";
        }
        // get rid of cards on_board
        for (var i = on_board.length-1; i >= 0; i--) {
            if (on_board[i] == -1) {
                on_board.splice(i, 1);
            } 
        }
        // display 
        for (var i = 0; i < 12; i++) {
            // get HTML element for each card from 4x3 table
            var cell = document.getElementById("cell".concat(i.toString()));
            // if current cell is within number of remaining cards, show it.
            // otherwise, hide the cell (no card available to display)
            if (i < on_board.length) {
                cell.innerHTML = '<img src="cards/'.concat(on_board[i].toString(), '.png">');
            } else {
                cell.style.visibility = "hidden";
            }
        }
    }

    // update remaining cards
    updateRemCount();
    // empty chosen array
    chosen = [];
    // check if any sets remain on board, if none, mark the time and make user restart game
    checkRemaining();
}


// this function checks if cards in chosen[] is a set
function chosenIsSet() {

    // get column at right of the screen with 3 card chosen by user
    document.getElementById("prevColumn").style.visibility = "visible";
    // get message element that displays if 3 cards in prevColumn was a set or not
    var status = document.getElementById("setStatus")
    // map indices of chosen cards in chosen to actual card numbers
    var cards = chosen.map(x => on_board[x]);

    // show each chosen card in prevColumn by using ps0, ps1, ps2 ID's
    for (var i in cards) {
        var img = '<img src="cards/'.concat(cards[i].toString(), '.png">');
        document.getElementById("ps".concat(i.toString())).innerHTML = img;
    }

    const names = {0:"color", 1:"number", 2:"shape", 3:"shading"};
    reasons = document.getElementById("reasons");
    reasons.innerHTML = "";
    // extract features array from each of the chosen cards
    const features = getFeatures(cards);

    // if the chosen 3 cards is a set, display message and replace cards
    if (isSet(features)) {
        status.innerHTML = "SET, +1 Score";
        status.style.color = "green";
        replaceCards(chosen);
        currentUserScore++;
    } else {
        // otherwise, it was not a set - show it was not a set message
        status.innerHTML = "Not a SET, -1 Score";
        status.style.color = "black";
        currentUserScore--;
        for (var i = 0; i < 4; i++) {
            if (features[i] > 0) {
                console.log(i)
                reasons.innerHTML += "<li>2 have same ".concat(names[i], "</li>");
            }
        }
        // check if any sets remain on board, if none, mark the time and make user restart game
        checkRemaining();
    }
    
}

// check if a set exists in input set of cards
function setExists(cards) {
    // loop through all combinations of cards within the deck
    for (var i = 0; i < cards.length; i++) {
        for (var j = i + 1; j < cards.length; j++) {
            for (var k = j + 1; k < cards.length; k++) {
                // if a current combination is a set, return true
                if (isSet(getFeatures([cards[i], cards[j], cards[k]]))) {
                    console.log(cards[i]);
                    console.log(cards[j]);
                    console.log(cards[k]);
                    return true;

                }   
            }
        }
    }
    // reaching this point means a set was not found - return false
    return false;
}

/*-------------------------------------------------------*/
/* -------------------Timer Vars ------------------------*/
/*-------------------------------------------------------*/

// start time 0
var start = 0;
// end is initially null - after first playthrough, it sets to best score
var end = null;
// get timer element from HTML (where time will be displayed)
var timer = document.getElementById("timer");

// This is the time allotted for timed mode.
var timesUp = 120;
// this formats the time, used in run_timer below
const time_padding = num => num.toString().padStart(2, '0');

/*-------------------------------------------------------*/
/* ------------------ Timer function ---------------------*/
/*-------------------------------------------------------*/

// update timer every 1000 ms MUST BE GLOBAL SO OTHER FUNCTIONS CAN ACCESS IT!
var run_timer = setInterval(function() {
    if (end == null) {
        // get time since game start in ms
        var elapsed_time = (new Date().getTime()) - start;
        // get secs, mins, hrs elapsed since game start
        var secs = Math.floor(elapsed_time / 1000);
        currentUserTime = secs;

        // only use a timer system of user wills it.
        if(useTimer === true && currentUserTime == timesUp){
            end = timer.innerHTML;
        }
        var mins = Math.floor(secs / 60);
        var hrs = Math.floor(mins/60);
        // set timer value to elapsed time accordingly
        timer.innerHTML = time_padding(hrs)  + ":" + 
                          time_padding(mins % 60) + ":" + 
                          time_padding(secs % 60);
        updatePlayer();
    } else {
        // if end is not null, a game has already been finished 
        // mark that time as score keeping
        timer.style.color = "blue";
        timer.innerHTML = end;
        //add player to array after timed game has been finished only
        if(useTimer === true){
            const user = new Player(currentUserName);
            user.score = currentUserScore;
            user.timeToFinish = currentUserTime;
            players.push(user);   
        }
        scoreboard();
    }
    // call every 1000 ms (1 s)
}, 1000);

/*-------------------------------------------------------*/
/* ----------------- Game function ---------------------*/
/*-------------------------------------------------------*/

function startGame() {
    //ask player for their name and store in Mao
    currentUserName = promptName();
    currentUserScore = 0;
    currentUserTime = 0;
    // ask player if they want to use timed mode
    useTimer = promptUseTimer();
    // fill deck with 81 cards and shuffle
    initializeDeck();
    // deal 12 cards onto board
    dealCards();
    // update number of remaining cards in deck
    updateRemCount();

    // timer vars
    end = null;
    start = new Date().getTime();
    timer.style.color = "black";
    timer.innerHTML = "00:00:00";
    
}


/*-------------------------------------------------------*/
/* ----------------- Score Board Function ---------------------*/
/*-------------------------------------------------------*/
// game over function/scoreboard function
function scoreboard() {
  //order the array of players using a comparator 
  var scores = document.getElementById("scores");
  players.sort( (a,b) => b.score - a.score); 
  for(let m = 0; m < players.length - 1; m++){
    // delete past table so we can update with new one.
    scores.deleteRow(-1);
  }

  // remake table such that it's sorted properly.
  for(let i = 0; i < players.length; i++){
      var row = scores.insertRow(-1);
      var cell0 = row.insertCell(0);
      var cell1 = row.insertCell(1);
      var cell2 = row.insertCell(2);
      cell0.innerHTML = players[i].name;
      cell1.innerHTML = players[i].score.toString();
      cell2.innerHTML = players[i].timeToFinish.toString();
  }
  // clear timer once you print scoreboard
  clearInterval(run_timer);
  promptPlayAgain();
}
function updatePlayer(){
    var player = document.getElementById("player");
    player.innerHTML = "Name:" + currentUserName + " Score:" + currentUserScore.toString();
}
/*-------------------------------------------------------*/
/* ----------------- Player Function ---------------------*/
/*-------------------------------------------------------*/
// asks for user name
function promptName(){
    var name = prompt('Welcome player! What is your name?');
    return name;  
}
// ask if user wants to do timed mode.
function promptUseTimer(){
    let useTimer = false;
    useTimer = confirm('Do you want to use the timed mode? Note: Only timed scores are on the leaderboard, Ok enables timer mode, cancel does not!');
    
    return useTimer;
}

// prompt play again option
function promptPlayAgain(){
    let playAgain = false;
    let ui = prompt("Game Over!, Play again? Y/N?");
    if (ui === 'Y'){
       startGame();
       end = null; // make sure to allow for the timer to keep going again every playthrough.
       run_timer = setInterval(function() {
        if (end == null) {
            // get time since game start in ms
            var elapsed_time = (new Date().getTime()) - start;
            // get secs, mins, hrs elapsed since game start
            var secs = Math.floor(elapsed_time / 1000);
            currentUserTime = secs;
    
            // only use a timer system of user wills it.
            if(useTimer === true && currentUserTime == timesUp){
                end = timer.innerHTML;
            }
            var mins = Math.floor(secs / 60);
            var hrs = Math.floor(mins/60);
            // set timer value to elapsed time accordingly
            timer.innerHTML = time_padding(hrs)  + ":" + 
                              time_padding(mins % 60) + ":" + 
                              time_padding(secs % 60);
            updatePlayer();
        } else {
            // if end is not null, a game has already been finished 
            // mark that time as score keeping
            timer.style.color = "blue";
            timer.innerHTML = end;
            //add player to array after game has been finished
            const user = new Player(currentUserName);
            user.score = currentUserScore;
            user.timeToFinish = currentUserTime;
            players.push(user);    
            scoreboard();
        }
        // call every 1000 ms (1 s)
    }, 1000);
    }else{
       window.alert("GAME OVER!");
    }
}


