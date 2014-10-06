require 'rspec'
require_relative 'hex.rb'


describe 'coordinate' do
  before(:each) do
    @coordinate = Coordinate.new
  end

  describe 'coordinates' do
    it 'should consist of at least two angle-step pairs' do
      expect(@coordinate.coordinates).to eq []
    end
    it 'adding an angle-step pair will reduce back to two angle-step pairs or less' do
      @coordinate.add_angle_step([60,1])
      expect(@coordinate.angle_steps).to eq [
        [60,1],
      ]
    end
    it 'two angle-step pairs will reduce to one if their angles are the same' do
      @coordinate.add_angle_step [60,1]
      @coordinate.add_angle_step [60,1]
      expect( @coordinate.angle_steps).to eq [
        [60,2],
      ]
    end
    it 'two angle-step pairs will reduce to one if their angles are complements' do
      @coordinate.add_angle_step [60,1]
      @coordinate.add_angle_step [240,1]
      expect(@coordinate.angle_steps).to eq []
    end
  end

  describe 'angle step pairs' do
    describe '#angle_step_complement' do
      it 'should return the equivalent angle step pair from the other direction' do
        expect(Coordinate.angle_step_complement([60,1])).to eq [240, -1]
        expect(Coordinate.angle_step_complement([120,-1])).to eq [300, 1]
      end
    end
    describe '#angle_step_reduce' do
      it 'should return the equivalent angle step pairs by reduction' do
        expect(Coordinate.angle_step_reduce([60,1])).to eq [[120, 1],[0, 1]]
      end
    end
    describe '#add_angle_step' do
      it 'should return the equivalent angle step pairs by reduction' do
        expect(Coordinate.angle_step_reduce([60,1])).to eq [[120, 1],[0, 1]]
      end
    end

  end
end



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
end
