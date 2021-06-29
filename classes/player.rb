class Player
  # represents participants in the game
  attr_accessor :deck, :score, :hand, :name

  def initialize(deck, name)
    self.deck = deck
    self.score = 0
    self.hand = []
    self.name = name
  end

  def hit
    puts "#{self.name} Hits!"
    self.hand.append(self.deck.cards.pop)
  end

  def stay
    if self.score < 22
      puts "#{self.name} Stays!"
    else
      puts "#{self.name} Busts!"
    end
    return
  end

  def deal
    self.deck.cards.pop(2)
  end

end
