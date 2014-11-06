require_relative '../../hex'
class ShellController < ApplicationController

  def shell
    if Round.any?
      round = Round.last
    else
      round = Round.create points: "[[0,1],[60,4],[240,1],[0,0]]"
    end

    session[:step] ||= 0
    session[:step] += 1

    session[:coordinates] = [
      [0,1,60,2],
      [0,1,60,0],
      [0,1,60,-1],
      [0,0,60,2],
      [0,0,60,0],
      [0,0,60,-1],
      [0,2,60,2],
      [0,0,60,1],
      [0,3,60,2],
    ]

    @board = Board.new
    (session[:coordinates]).each do |coordinate|
      @board.add_cell Coordinate.new(coordinate)
    end
    session[:temp] = @board.cells.to_a
    @board.next_cycle

    session[:coordinates] = @board.cells.to_a
    binding.pry
  end

end
