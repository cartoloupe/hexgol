require 'pry'
require 'set'

class Coordinate
  attr_accessor :coordinates

  def initialize(theta=0, xstep=0, phi=0, ystep=0)
    @coordinates = []
    add_angle_step([theta, xstep])
    add_angle_step([phi, ystep])
  end

  def to_s
    @coordinates
  end
  alias :angle_steps :to_s

  def angles
    @coordinates.map(&:first)
  end

  def complements
    @coordinates.map(&:first).map{|angle| (angle + 180) % 360 }
  end

  def ==(another_coordinate)
    @coordinates == another_coordinate.coordinates
  end

  def hash
    @coordinates.hash
  end

  def eql?(another_coordinate)
    @coordinates == another_coordinate.coordinates
  end

  def sort_pairs!
    @coordinates.sort!
  end

  def add_angle_step(angle_step)
    angle,step = *angle_step
    if complements.include? angle
      angle,step = Coordinate.angle_step_complement(angle_step)
    end

    @coordinates << [angle,step]
    sort_pairs!
    reduce_zero_steps
    simplify_angle_step_pairs!
    reduce_zero_steps
    while angles.size > 2
      restate_pairs
      sort_pairs!
      simplify_angle_step_pairs!
      reduce_zero_steps
    end
    self
  end

  def normalize!
    zero = -> {@coordinates[0].first}
    sixty = -> {@coordinates[1].first}
    nothing_else = -> {@coordinates.size == 2}
    @coordinates << [0,0]
    @coordinates << [60,0]
    until (zero.() == 0 && sixty.() == 60 && nothing_else.()) do
      sort_pairs!
      # complement
      @coordinates.map! do |angle,step|
        if angle >= 180
          angle,step = Coordinate.angle_step_complement([angle,step])
        end
        [angle,step]
      end
      simplify_pairs!
      # reduce
      new_coordinates = []
      @coordinates.each do |angle_step|
        angle,step = *angle_step
        if angle > 60
          angle_steps = Coordinate.angle_step_reduce([angle,step])
        else
          angle_steps = [[angle,step]]
        end
        angle_steps.each do |angle_step|
          new_coordinates << angle_step
        end
      end
      @coordinates = new_coordinates

      simplify_pairs!
    end
    self
  end

  def simplify_pairs!
    sort_pairs!
    simplify_angle_step_pairs!
  end

  def restate_pairs
    pair = Coordinate.angle_step_reduce(@coordinates.pop)
    pair.each do |angle_step|
      add_angle_step(angle_step)
    end
  end

  def simplify_angle_step_pairs!
    @coordinates.each_cons(2).each_with_index{|cons, i|
      angle_step_first, angle_step_second = cons.first,cons.last
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
  attr_accessor :cells

  def initialize
    @cells = Set.new
  end

  def add_cell coordinate
    @cells.add(coordinate)
  end

  def has_cell? coordinate
    @cells.include? coordinate
  end

  def live_neighbors(coordinate)
    neighbors(coordinate).count do |neighbor|
      has_cell? neighbor
    end
  end

  def neighbors(coordinate)
    Set.new [0,60,120,180,240,300].map do |angle|
      neighbor = Coordinate.new(*(coordinate.coordinates).flatten)
      neighbor.add_angle_step([angle, 1])
      neighbor.normalize!
    end
  end

  def surrounding_cells
    cells_to_check = Set.new
    # get all neighbors of cells
    # and the cells themselves
    @cells.each do |cell|
      cells_to_check.add cell
      neighbors(cell).each do |neighbor|
        cells_to_check.add neighbor
      end
    end
    cells_to_check
  end

  def next_cycle
  end
end


