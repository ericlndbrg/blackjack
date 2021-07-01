#!/usr/bin/env ruby

require_relative 'classes/game'

puts '*' * 30
puts 'BLACKJACK'
puts 'Options:'
puts '1: play a single hand.'
puts '2: play multiple hands.'
puts 'Type in option and press Enter.'
puts '*' * 30

def get_player_preference
  # allows the player to choose if they want to
  # play a single hand or play until the shoe needs
  # to be reshuffled (when < 2 decks remain)

  # get the user's preference
  player_preference = gets.chomp

  # validate the player's input, should only be 1 or 2
  if ['1', '2'].include?(player_preference)
    return player_preference
  else
    puts 'Invalid input, please try again.'
    get_player_preference
  end
end

player_preference = get_player_preference
blackjack = Game.new(player_preference)
blackjack.play
