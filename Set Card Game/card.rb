# frozen_string_literal: true

#     Card is foundational object of Game of Set
#
#     instance variables:
#         @num
#             number, takes on "1", "2", or "3"
#
#         @col
#             color, takes on "red", "purple", or "green"
#
#         @sym
#             symbol, takes on "oval", "squiggle", or "diamond"
#
#         @shade
#             shading, takes on "solid", "striped", or "outlined"
#
#         ***Card objects are initialized in board.rb constructor
#         ***when @Deck gets populated
class Card
  # constructor
  def initialize(num, col, sym, shade)
    @num = num # number
    @col = col # color
    @sym = sym # symbol
    @shade = shade # shade color of background of card
  end

  # getter methods
  attr_reader :num
  attr_reader :sym, :col, :shade
end

#     CardChecker is a utility object for checking if 3 cards are a set.
#
#     methods :
#         check_[ATTRIBUTE] for each attribute (number, symbol, shade, color)
#             returns true if attribute are all same/different, returns false otherwise
#         is_set(card1, card2, card3)
#             returns true if three cards are a set
class CardChecker
  # constructor
  def initialize; end

  # check number atribute
  def check_num(card1, card2, card3)
    # checks for all same
    same_num = (card1.num == card2.num) && (card2.num == card3.num)
    # checks for all diff
    diff_num = (card1.num != card2.num) && (card2.num != card3.num) && (card1.num != card3.num)

    same_num || diff_num
  end

  # check symbol atribute
  def check_sym(card1, card2, card3)
    # checks for all same
    same_sym = (card1.sym == card2.sym) && (card2.sym == card3.sym)
    # checks for all diff
    diff_sym = (card1.sym != card2.sym) && (card2.sym != card3.sym) && (card1.sym != card3.sym)

    (same_sym || diff_sym)
  end

  # check shade atribute
  def check_shade(card1, card2, card3)
    # checks for all same
    same_shade = (card1.shade == card2.shade) && (card2.shade == card3.shade)
    # checks for all diff
    diff_shade = (card1.shade != card2.shade) && (card2.shade != card3.shade) && (card1.shade != card3.shade)

    (same_shade || diff_shade)
  end

  # check color atribute
  def check_col(card1, card2, card3)
    # checks for all same
    same_col = (card1.col == card2.col) && (card2.col == card3.col)
    # checks for all diff
    diff_col = (card1.col != card2.col) && (card2.col != card3.col) && (card1.col != card3.col)

    (same_col || diff_col)
  end

  # is_a_set checks if a set of 3 cards is a set
  def set?(card1, card2, card3)
    (check_num(card1, card2, card3) &&
      check_sym(card1, card2, card3) &&
      check_col(card1, card2, card3) &&
      check_shade(card1, card2, card3))
  end
end
