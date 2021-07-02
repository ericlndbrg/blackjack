require_relative '../classes/game'

describe 'Game' do

  describe '#calculate_value' do

    it 'calculates non-face card hands correctly' do
      blackjack = Game.new(1)
      random_number_one = rand(2..10)
      random_number_two = rand(2..10)
      hand = [Card.new(random_number_one.to_s, 'h'), Card.new(random_number_two.to_s, 's')]
      value = blackjack.send(:calculate_value, hand, blackjack.player)
      expect(value).to eq(random_number_one + random_number_two)
    end

    it 'calculates face cards correctly' do
      blackjack = Game.new(1)
      hand = [Card.new('J', 'h'), Card.new('Q', 's')]
      value = blackjack.send(:calculate_value, hand, blackjack.player)
      expect(value).to eq(20)
    end

    describe 'aces' do

      it 'calculates an ace as 11 correctly' do
        blackjack = Game.new(1)
        hand = [Card.new('A', 'h'), Card.new('8', 's')]
        value = blackjack.send(:calculate_value, hand, blackjack.player)
        expect(value).to eq(19)
      end

      it 'calculates an ace as 1 correctly' do
        blackjack = Game.new(1)
        hand = [Card.new('A', 'h'), Card.new('8', 's'), Card.new('3', 'c')]
        value = blackjack.send(:calculate_value, hand, blackjack.player)
        expect(value).to eq(12)
      end

      it 'calculates 2 aces correctly, same value' do
        blackjack = Game.new(1)
        hand = [Card.new('A', 'h'), Card.new('8', 's'), Card.new('3', 'c'), Card.new('A', 'd')]
        value = blackjack.send(:calculate_value, hand, blackjack.player)
        expect(value).to eq(13)
      end

      it 'calculates 2 aces correctly, different values' do
        blackjack = Game.new(1)
        hand = [Card.new('A', 'h'), Card.new('A', 's'), Card.new('8', 's')]
        value = blackjack.send(:calculate_value, hand, blackjack.player)
        expect(value).to eq(20)
      end

    end

  end

  it '#get_player_action, player hits until score is >= 17' do
    blackjack = Game.new(1)
    blackjack.player.score = 10
    blackjack.send(:get_player_action, blackjack.player)
    expect(blackjack.player.score).to be >= 17
  end

  it '#get_player_action, player stays if score is >= 17' do
    blackjack = Game.new(1)
    blackjack.player.score = 17
    blackjack.send(:get_player_action, blackjack.player)
    expect(blackjack.player.score).to be 17
  end

end
