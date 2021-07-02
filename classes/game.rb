class Game
  # represents a game of blackjack
  require_relative './player'
  require_relative './card_shoe'
  attr_accessor :card_shoe, :dealer, :player, :player_preference
  
  def initialize(player_preference)
    # set player preference
    self.player_preference = player_preference

    # make a card shoe
    self.card_shoe = CardShoe.new

    # make a player and a dealer
    # pass in the card shoe (by reference) so that
    # the players are dealt cards from the same shoe
    self.dealer = Player.new(self.card_shoe.cards, 'Dealer')
    self.player = Player.new(self.card_shoe.cards, 'Player')
  end

  def play
    # play a single hand
    if self.player_preference == 1.to_s
      blackjack
      puts '' # spacer for readability
    else
      # play until there are only 2 decks left in the shoe
      until self.player.cards.length < 104
        blackjack
        puts '' # spacer for readability
      end
      puts 'Time to reshuffle what\'s left in the shoe!'
      self.card_shoe.cards.shuffle!
    end
  end

  private

  def blackjack
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
      # if (player.score > 21 && dealer.score <= 21) || (player.score > 21 && dealer.score > 21)
      if player.score > 21
        # since the player always goes first,
        # if the player busts, the dealer doesn't play their hand
        # and automatically wins
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
  end

  def calculate_value(hand, player)
    value = 0

    # break up the hand into 2 arrays,
    # 1 containing aces, 1 without aces
    aces_only = hand.select { |card| card.number.include?('A') }
    no_aces = hand.select { |card| !card.number.include?('A') }

    no_aces.each do |card|
      number = card.number
      # cards with numbers of 2-10
      # their value equals their numbers
      if ('2'..'10').include?(number)
        value += number.to_i
      else
        # jacks, queens and kings are valued at 10
        value += 10
      end
    end

    unless aces_only.empty?
      # skip this if the hand doesn't contain aces
      aces_only.each do |card|
        # aces can have a value of 1 or 11 depending
        if value + 11 > 21
          # count as 1 to avoid busting
          value += 1
        else
          value += 11
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
