class Game
  require_relative './player'
  require_relative './card_shoe'
  attr_accessor :card_shoe, :dealer, :player
  
  def initialize
    # make a card shoe
    self.card_shoe = CardShoe.new

    # make a player and a dealer
    # pass in the card shoe (by reference) so that both
    # the player and the dealer have access to the same card shoe
    self.dealer = Player.new(self.card_shoe.cards, 'Dealer')
    self.player = Player.new(self.card_shoe.cards, 'Player')
  end

  def play

    until self.player.cards.length < 104
      # deal cards
      self.player.hand = dealer.deal
      self.dealer.hand = dealer.deal

      # display hands from deal
      get_game_info(self.player)
      get_game_info(self.dealer)

      # player plays the hand
      get_player_action(player)

      # dealer's turn, but only if the player didn't bust
      get_player_action(dealer) if player.score < 22

      # display winner
      puts "Player's Score: #{player.score}"
      puts "Dealer's Score: #{dealer.score}"

      if [player.score, dealer.score].max > 21
        # at least one player busted
        if (player.score > 21 && dealer.score <= 21) || (player.score > 21 && dealer.score > 21)
          # the dealer wins no matter if only the player busts, or both bust
          puts 'Dealer Wins!'
        else
          # dealer busts, player doesn't
          puts 'Player Wins!'
        end
      else
        # neither player busted
        if player.score < dealer.score
          # player's score is less than the dealer's
          puts 'Dealer Wins!'
        elsif player.score > dealer.score
          # player's score is greater than the dealer's
          puts 'Player Wins!'
        else
          # player's score is equal to the dealer's
          puts 'Push!'
        end
      end
      puts self.player.cards.length
    end
  end

  private

  def calculate_value(hand, player)
    value = 0
    hand.each do |card|
      number = card.number
      if (1..10).include?(number)
        value += number
      else
        if ['J', 'Q', 'K'].include?(number)
          value += 10
        else
          # ace, value can equal 1 or 11 depending
          # handle these scenarios:
          #   Player's Hand: Ah - 3c - 8c, Player's Score: 22
          #     should be 12
          #   Player's Hand: 2h - Ad - Ah - Kc, Player's Score: 24
          #     should be 14
          if value + 11 > 21
            value += 1
          else
            value += 11
          end
        end
      end
    end
    player.score = value
  end

  def display_hand(hand)
    results = hand.map do |card|
      "#{card.number}#{card.suit}"
    end
    results.join(' - ')
  end

  def get_player_action(player)
    if player.score < 17
      until player.score >= 17
        player.hit
        get_game_info(player)
      end
    end
    player.stay
  end

  def get_game_info(player)
    puts "#{player.name}'s Hand: #{display_hand(player.hand)}, #{player.name}'s Score: #{calculate_value(player.hand, player)}"
  end

end
