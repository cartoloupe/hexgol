require 'rspec'
require_relative 'hex.rb'


describe 'coordinate' do
  before(:each) do
    @coordinate = Coordinate.new
  end

  describe 'structure' do
    it 'should consist of at least a quad of numbers' do
      expect(@coordinate.theta).to eq 0
      expect(@coordinate.xstep).to eq 0
      expect(@coordinate.phi).to eq 0
      expect(@coordinate.ystep).to eq 0
    end
  end


  describe 'coordinates' do
    it 'should consist of at least two angle-step pairs' do
      expect(@coordinate.coordinates).to eq [
        [0,0],
        [0,0],
      ]
    end
    it 'adding an angle-step pair will reduce back to two angle-step pairs or less' do
      expect(@coordinate.add_angle_step [60,1]).to eq [
        [60,1],
      ]
    end
    it 'two angle-step pairs will reduce to one if their angles are the same' do
      @coordinate.add_angle_step [60,1]
      expect( @coordinate.add_angle_step [60,1]).to eq [
        [60,2],
      ]
    end
    it 'two angle-step pairs will reduce to one if their angles are complements' do
      @coordinate.add_angle_step [60,1]
      expect( @coordinate.add_angle_step [240,1]).to eq []
    end
  end

  describe 'angle step pairs' do
    describe '#angle_step_complement' do
      it 'should return the equivalent angle step pair from the other direction' do
        expect(Coordinate.angle_step_complement([60,1])).to eq [240, -1]
        expect(Coordinate.angle_step_complement([120,-1])).to eq [300, 1]
      end
    end
  end
end



describe 'board' do
  board = Board.new
  describe '#neighbors' do
    xit 'returns 6 neighbors' do
      expect(board.neighbors(Coordinate.new).size).to eq 6
    end

    xit 'returns 6 neigboring coordinates' do
      expect(board.neighbors(Coordinate.new)).to eq [
        Coordinate.new(  0,1,0,0),
        Coordinate.new( 60,1,0,0),
        Coordinate.new(120,1,0,0),
        Coordinate.new(180,1,0,0),
        Coordinate.new(240,1,0,0),
        Coordinate.new(300,1,0,0),
      ]
    end

  end
end
