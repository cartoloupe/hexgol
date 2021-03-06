require 'rspec'
require_relative '../hex'

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

    describe '#normalize!' do
      it 'normalizes coordinates to "[0,x],[60,y]" form' do
        coordinate = Coordinate.new(300,3,240,4)
        coordinate.normalize!
        expect(coordinate.coordinates).to eq [[0,3], [60,-7]]
      end
    end

  end

  describe '#quadrant' do
    it 'returns 2 for (0,-1,60,1)' do
      expect(Coordinate.new(0,-1,60,1).quadrant).to eq 2
      expect(Coordinate.new(0,0,120,1).quadrant).to eq 2
    end
    it 'returns 4 for (0,0,120,-1)' do
      expect(Coordinate.new(0,0,120,-1).quadrant).to eq 4
    end
  end

  describe '#to_polar' do
    it 'converts hex coordinates to polar coordinates extensively' do
      (-15..15).each do |n|
        (-15..15).each do |m|
          coordinate = Coordinate.new(0,n,60,m)
          #puts "#{n}, #{m}"
          expect(-> {coordinate.to_polar}).not_to raise_error
        end
      end
    end
  end

  describe '#to_xy' do
    it 'converts hex coordinates to x,y coordinates in quadrant I' do
      coordinate = Coordinate.new(0,3,60,2)
      expect(coordinate.to_xy).to eq [4.000, 1.732]
      coordinate = Coordinate.new(0,0,60,2)
      expect(coordinate.to_xy).to eq [1.000, 1.732]
      coordinate = Coordinate.new(0,4,60,0)
      expect(coordinate.to_xy).to eq [4.000, 0.000]
    end
    it 'converts hex coordinates to x,y coordinates in quadrant II' do
      coordinate = Coordinate.new(0,-3,60,2)
      expect(coordinate.to_xy).to eq [-2.0, 1.732]
      coordinate = Coordinate.new(0,-3,60,0)
      expect(coordinate.to_xy).to eq [-3.000, 0.000]
    end
    it 'converts hex coordinates to x,y coordinates in quadrant III' do
      coordinate = Coordinate.new(0,-3,60,-2)
      expect(coordinate.to_xy).to eq [-4.000, -1.732]
    end
    it 'converts hex coordinates to x,y coordinates in quadrant IV' do
      coordinate = Coordinate.new(0,3,60,-2)
      expect(coordinate.to_xy).to eq [2.0, -1.732]
      coordinate = Coordinate.new(0,0,120,-1)
      expect(coordinate.to_xy).to eq [0.500, -0.866]
    end
    it 'converts hex coordinates to x,y coordinates at the origin' do
      coordinate = Coordinate.new(0,0,60,0)
      expect(coordinate.to_xy).to eq [0.0, 0.0]
    end
    it 'converts hex coordinates to x,y coordinates extensively' do
      (-15..15).each do |n|
        (-15..15).each do |m|
          coordinate = Coordinate.new(0,n,60,m)
          expect(-> {coordinate.to_xy}).not_to raise_error
        end
      end
    end
  end

end


