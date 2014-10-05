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

  def angles
    @coordinates.map(&:first)
  end

  def complements
    @coordinates.map(&:first).map{|angle| (angle + 180) % 360 }
  end

  def add_angle_step(angle_step)
    angle,step = *angle_step
    if complements.include? angle
      angle,step = Coordinate.angle_step_complement(angle_step)
    end
    @coordinates << [angle,step]
    @coordinates.sort!
    @coordinates.reject!{|c| c == [0,0]}
    reduce_angle_step_pairs
    reduce_zero_steps
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

  def reduce_zero_steps
    @coordinates.reject!{|c|c.last == 0}
  end

  def self.angle_step_complement(angle_step)
    angle = (angle_step.first + 180) % 360
    step = angle_step.last * -1
    [angle,step]
  end

  def self.angle_step_reduce(angle_step)
    angle, step = *angle_step
    angles = [
      (angle + 60) % 360,
      (angle - 60) % 360,
    ]
    angles.map{|angl| [angl, step]}
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


