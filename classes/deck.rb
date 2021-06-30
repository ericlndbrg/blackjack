class Deck
  # represents a deck of cards
  require_relative './card'
  attr_accessor :cards

  def initialize
    cards = []
    suits = ['s', 'h', 'c', 'd']
    numbers = ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K']

    suits.each do |suit|
      numbers.each do |number|
        card = Card.new(number, suit)
        cards.push(card)
      end
    end
    self.cards = cards
  end

end
