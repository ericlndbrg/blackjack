class Card
  # represents a card in a deck
  attr_accessor :number, :suit

  def initialize(number, suit)
    self.number = number
    self.suit = suit
  end
  
end
