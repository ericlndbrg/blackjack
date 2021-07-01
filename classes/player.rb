class Player
  # represents participants in the game
  attr_accessor :cards, :score, :hand, :name

  def initialize(cards, name)
    self.cards = cards
    self.score = 0
    self.hand = []
    self.name = name
  end

  def hit
    puts "#{self.name} Hits!"
    self.hand.append(self.cards.pop)
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
    if self.name == 'Dealer'
      self.cards.pop(2)
    else
      puts 'Only dealers can deal cards!'
      return
    end
  end

end
