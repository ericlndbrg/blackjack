require_relative '../classes/deck'

describe 'Deck' do

  it 'a new deck contains 52 cards' do
    deck = Deck.new
    expect(deck.cards.length).to eq(52)
  end

  it 'the first card must be an ace of spades' do
    deck = Deck.new
    first_card_number = deck.cards.first.number
    first_card_suit = deck.cards.first.suit
    expect("#{first_card_number}#{first_card_suit}").to eq('As')
  end

  it 'the last card must be a king of diamonds' do
    deck = Deck.new
    last_card_number = deck.cards.last.number
    last_card_suit = deck.cards.last.suit
    expect("#{last_card_number}#{last_card_suit}").to eq('Kd')
  end
  
end
