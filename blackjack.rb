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

def get_player_action(player)
  calculate_value(player.hand, player)
  if player.score < 17
    until player.score >= 17
      player.hit
      puts "#{player.name}'s Hand: #{display_hand(player.hand)}, #{player.name}'s Score: #{calculate_value(player.hand, player)}"
    end
  end
  player.stay
end

def blackjack
  # get a new deck
  deck = Deck.new

  # shuffle cards
  deck.cards.shuffle!

  # make a player and a dealer
  # pass in the deck (by reference) so that both
  # the player and the dealer have access to the same deck
  dealer = Player.new(deck, 'Dealer')
  player = Player.new(deck, 'Player')

  # deal cards
  player.hand = dealer.deal
  dealer.hand = dealer.deal

  # display hands from deal
  puts "#{player.name}'s Hand: #{display_hand(player.hand)}, #{player.name}'s Score: #{calculate_value(player.hand, player)}"
  puts "#{dealer.name}'s Hand: #{display_hand(dealer.hand)}, #{dealer.name}'s Score: #{calculate_value(dealer.hand, dealer)}"

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

end

blackjack
