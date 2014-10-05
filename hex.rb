require 'pry'

class Coordinate
  attr_accessor :theta, :xstep, :phi, :ystep, :coordinates

  def initialize(theta=0, xstep=0, phi=0, ystep=0)
    @theta = theta
    @xstep = xstep
    @phi = phi
    @ystep = ystep
    @coordinates = make_coords
  end

  def make_coords
    [
      [theta, xstep],
      [phi, ystep],
    ]
  end

  def add_angle_step(xy)
    @coordinates << [xy.first,xy.last]
    @coordinates.sort!
    @coordinates.reject!{|c| c == [0,0]}
    reduce_angle_step_pairs
    @coordinates
  end

  def reduce_angle_step_pairs
    @coordinates.each_cons(2).each_with_index{|cons, i|
      angle_step_first = cons.first
      angle_step_second = cons.last
      if angle_step_first.first == angle_step_second.first
        angle_step_second[1] = angle_step_second.last + angle_step_first.last
        @coordinates.delete_at i
      end
    }
  end

  def self.angle_step_complement(angle_step)
    angle = (angle_step.first + 180) % 360
    step = angle_step.last * -1
    [angle,step]
  end


end


class Board

  def initialize

  end

  def neighbors(coordinate)
    [
      Coordinate.new(coordinate),
    ]
  end
end


