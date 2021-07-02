require_relative '../classes/card'

describe 'Card' do

  it 'allows reading and writing for :number' do
    card = Card.new('3', 'h')
    expect(card.number).to eq('3')
  end

  it 'allows reading and writing for :suit' do
    card = Card.new('5', 'c')
    expect(card.suit).to eq('c')
  end

end
