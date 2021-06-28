class Player
  # represents participants in the game
  attr_accessor :deck, :score, :hand

  def initialize(deck)
    self.deck = deck
    self.score = 0
    self.hand = []
  end

  def hit
    self.hand.append(self.deck.cards.pop)
  end

  def stay
    return
  end

  def deal
    self.deck.cards.pop(2)
  end

end
