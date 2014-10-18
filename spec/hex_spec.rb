require 'rspec'
require_relative '../hex'

describe 'board' do
  before(:each) do
    @board = Board.new
  end
  describe '#neighbors' do
    it 'returns 6 neighbors' do
      expect(@board.neighbors(Coordinate.new).size).to eq 6
    end

    it 'returns 6 neigboring coordinates' do
      expect(@board.neighbors(Coordinate.new 0,1)).to eq Set.new [
        Coordinate.new(  0,0,0,0).normalize!,
        Coordinate.new( 60,1,0,0).normalize!,
        Coordinate.new(0,1,60,1).normalize!,
        Coordinate.new(0,2,0,0).normalize!,
        Coordinate.new(0,1,60,-1).normalize!,
        Coordinate.new(0,1,300,1).normalize!,
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

  describe '#surrounding_cells' do
    it 'returns the cells that could be changed' do
      @board.add_cell Coordinate.new(0,1)
      binding.pry
      expect(@board.surrounding_cells).to eq Set.new [
        Coordinate.new(  0,0,0,0).normalize!,
        Coordinate.new( 60,1,0,0).normalize!,
        Coordinate.new(  0,1,0,0).normalize!,
        Coordinate.new(300,1,0,0).normalize!,
        Coordinate.new(  0,1,60,1).normalize!,
        Coordinate.new(  0,2,0,0).normalize!,
        Coordinate.new(  0,1,300,1).normalize!,
      ]
    end
  end

  describe 'shuts down cells' do
    xit 'when a live cell has 0 or 1 neighbors' do
      @board.add_cell Coordinate.new(0,1)
      @board.add_cell Coordinate.new(0,-1)
      @board.add_cell Coordinate.new(60,-1)
    end
    xit 'when a live cell has 4,5, or 6 neighbors' do
    end
  end

  describe '#turns on cells' do
    xit 'when a dead cell has 3 neighbors' do
    end
  end

end
