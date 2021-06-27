class Player

  attr_accessor :deck

  def initialize(deck=nil)
    self.deck = deck
  end

  def hit
    self.deck.cards.pop(1)
  end

  def stay
  end

  def deal
    self.deck.cards.pop(2)
  end

end
