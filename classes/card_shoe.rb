class CardShoe
  # represents a card shoe
  # must contain 6 decks worth of cards
  require_relative './deck'
  attr_accessor :cards

  def initialize
    cards = []
    6.times {
      deck = Deck.new
      cards.push(deck.cards)
    }

    # a real card shoe isn't separated into decks
    cards.flatten!

    # shuffle the shoe
    cards.shuffle!

    self.cards = cards
  end

end
