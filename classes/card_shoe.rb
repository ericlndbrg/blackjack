class CardShoe
  require_relative './deck'
  attr_accessor :cards

  def initialize
    cards = []
    6.times {
      deck = Deck.new
      cards.push(deck.cards.shuffle!)
    }
    cards.flatten!
    self.cards = cards
  end

end
