require_relative '../../hex'
class ShellController < ApplicationController

  def set1
    session[:coordinates] = [
      [0,1,60,0],
      [0,-1,60,0],
      [0,0,60,1],
      [0,0,60,-1],
      [0,0,120,1],
      [0,0,120,-1],
      [0,5,60,-5],
      [0,5,60,-4],
      [0,5,60,-6],
      [0,4,60,-5],
      [0,3,60,-5],
      [0,0,120,-1],
      [0,0,120,-2],
      [0,0,60,-2],
      [0,0,0,0],
      [0,0,60,-3],
      [0,0,120,2],
    ]
  end

  def shell
    if Round.any?
      round = Round.last
    else
      round = Round.create points: "[[0,1],[60,4],[240,1],[0,0]]"
    end

    session[:step] ||= 0
    session[:step] += 1

    session[:coordinates] ||= [
      [0,1,60,0],
      [0,-1,60,0],
      [0,0,60,1],
      [0,0,60,-1],
      [0,0,120,1],
    ]

    @board = Board.new
    session[:coordinates].each do |coordinate|
      @board.add_cell Coordinate.new(*coordinate)
    end
    @board.next_cycle

    session[:coordinates] = @board.coordinates
  end

end
