#!/usr/bin/env ruby

require_relative 'classes/card'
require_relative 'classes/deck'
require_relative 'classes/player'

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

def get_dealer_action(dealer)
  # DRY this up
  calculate_value(dealer.hand, dealer)
  if dealer.score < 17
    until dealer.score >= 17
      dealer.hit
      puts 'Dealer Hits!'
      puts "Dealer's Hand: #{display_hand(dealer.hand)}, Dealer's Score: #{calculate_value(dealer.hand, dealer)}"
    end
  end
end

def get_player_action(player, dealer)
  # DRY this up
  calculate_value(player.hand, player)
  if player.score < 17
    until player.score >= 17
      player.hit
      puts 'Player Hits!'
      puts "Player's Hand: #{display_hand(player.hand)}, Player's Score: #{calculate_value(player.hand, player)}"
    end
  else
    player.stay
    puts 'Player Stays!'
  end
  get_dealer_action(dealer)
end

def blackjack
  # get a new deck
  deck = Deck.new

  # shuffle cards
  deck.cards.shuffle!

  # make a player and a dealer
  dealer = Player.new(deck)
  player = Player.new(deck)

  # deal cards
  player.hand = dealer.deal
  dealer.hand = dealer.deal

  # display hands from deal
  puts "Player's Hand: #{display_hand(player.hand)}, Player's Score: #{calculate_value(player.hand, player)}"
  puts "Dealer's Hand: #{display_hand(dealer.hand)}, Dealer's Score: #{calculate_value(dealer.hand, dealer)}"

  # prompt player for hit/stand
  get_player_action(player, dealer)

  # display winner
  puts "Player's Score: #{player.score}"
  puts "Dealer's Score: #{dealer.score}"
  # look into a double bust situation
  if player.score > 21
    puts 'Dealer Wins!'
  elsif dealer.score > 21
    puts 'Player Wins!'
  else
    # clean this up
    if player.score > dealer.score
      puts 'Player Wins!'
    elsif player.score < dealer.score
      puts 'Dealer Wins!'
    elsif player.score == dealer.score
      puts 'Push!'
    end
  end

end

blackjack
