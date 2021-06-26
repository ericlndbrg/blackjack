class Card
  # represents a card in a deck
  attr_writer :number, :suit

  def initialize(number, suit)
    self.number = number
    self.suit = suit
  end
  
end
