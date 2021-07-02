require_relative '../classes/card_shoe.rb'

describe 'CardShoe' do

  it 'a card shoe must have 6 decks worth of cards (312)' do
    card_shoe = CardShoe.new
    expect(card_shoe.cards.length).to eq(312)
  end

end
