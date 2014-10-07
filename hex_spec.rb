require 'rspec'
require_relative 'hex.rb'

describe 'board' do
  before(:each) do
    @board = Board.new
  end
  describe '#neighbors' do
    it 'returns 6 neighbors' do
      expect(@board.neighbors(Coordinate.new).size).to eq 6
    end

    it 'returns 6 neigboring coordinates' do
      expect(@board.neighbors(Coordinate.new)).to eq [
        Coordinate.new(  0,1,0,0),
        Coordinate.new( 60,1,0,0),
        Coordinate.new(120,1,0,0),
        Coordinate.new(180,1,0,0),
        Coordinate.new(240,1,0,0),
        Coordinate.new(300,1,0,0),
      ]
    end
  end

  describe '#add_cell' do
    it 'adds a coordinate to the board' do
      @board.add_cell Coordinate.new(0,1,60,2)
      expect(@board.cells.size).to eq 1
      @board.add_cell Coordinate.new(0,1,60,2)
      expect(@board.cells.size).to eq 1
      @board.add_cell Coordinate.new(0,1,60,4)
      expect(@board.cells.size).to eq 2
    end
  end


  describe '#has_cell?' do
    it 'checks to see if coordinate exists on board' do
      @board.add_cell Coordinate.new(0,1,60,2)
      @board.add_cell Coordinate.new(0,4,60,2)
      @board.add_cell Coordinate.new(300,1,60,2)
      expect(@board.has_cell?(Coordinate.new(0,4,60,2))).to be true
      expect(@board.has_cell?(Coordinate.new(0,5,60,2))).to be false
    end
  end

  describe '#live_neighbors' do
    it 'reports number of live neighbors of a coordinate' do
      @board.add_cell Coordinate.new(0,1)
      @board.add_cell Coordinate.new(180,1)
      @board.add_cell Coordinate.new(0,1,60,2)
      @board.add_cell Coordinate.new(300,1,60,2)
      expect(@board.live_neighbors(Coordinate.new())).to eq 2
    end
  end

end
