require_relative '../classes/player'
require_relative '../classes/card_shoe'

describe 'Player' do

  describe '#initialize' do

    it ':cards must be a full shoe' do
      player = Player.new(CardShoe.new.cards, 'Player')
      expect(player.cards.length).to eq(312)
    end

    it ':score must be 0' do
      player = Player.new(CardShoe.new.cards, 'Player')
      expect(player.score).to be(0)
    end

    it ':hand must be an empty array' do
      player = Player.new(CardShoe.new.cards, 'Player')
      expect(player.hand).to be_empty
    end

    it ':name must match the argument' do
      player = Player.new(CardShoe.new.cards, 'Player')
      expect(player.name).to eq('Player')
    end

  end

  it '#hit adds one card to the player\'s hand' do
    card_shoe = CardShoe.new
    player = Player.new(card_shoe.cards, 'Player')
    dealer = Player.new(card_shoe.cards, 'Dealer')
    player.hand = dealer.deal
    player.hit
    expect(player.hand.length).to eq(3)
  end

  it '#stay does not change the number of cards in a player\'s hand' do
    dealer = Player.new(CardShoe.new.cards, 'Dealer')
    dealer.hand = dealer.deal
    dealer.stay
    expect(dealer.hand.length).to eq(2)
  end

  describe '#deal' do

    it 'dealing must put 2 cards in a player\'s hand' do
      dealer = Player.new(CardShoe.new.cards, 'Dealer')
      dealer.hand = dealer.deal
      expect(dealer.hand.length).to eq(2)
    end

    it 'both players play with the same card shoe' do
      card_shoe = CardShoe.new
      player = Player.new(card_shoe.cards, 'Player')
      dealer = Player.new(card_shoe.cards, 'Dealer')
      player.hand = dealer.deal
      dealer.hand = dealer.deal
      expect(player.cards.length).to eq(dealer.cards.length)
    end

  end

end
