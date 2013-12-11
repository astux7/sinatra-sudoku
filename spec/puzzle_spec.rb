require_relative '../lib/puzzle'

describe Puzzle do 
  let(:puzzle) {Puzzle.new}

  it 'should get the 81 element' do
     expect(puzzle.sudoku.count).to eq(81)
     puzzle.hide_cells
     puzzle.inspect
  end
  
  it 'should hide some cells ' do

  end

	
end