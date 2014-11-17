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

  def add_cell
    if params[:coordinates]
      p params
      p params[:coordinates].map{|k,v|v}
      coordinateses = params[:coordinates].map{|k,v|v}.map{|v|v.map(&:to_i)}
    else
      coordinateses = [[0,30,60,10]]
    end
    coordinateses.each do |coordinates|
      session[:coordinates] << coordinates
    end

    render :nothing => true
    #display_board
    #render 'shell'
    #redirect_to shell_refresh_path
  end

  def restart
    session[:step] = 0
    if session[:step] == 0
      set1
    end
    session[:step] += 1
    run_board
    render 'shell'
  end

  def refresh
    display_board
    render 'shell'
  end

  def shell
    if Round.any?
      round = Round.last
    else
      round = Round.create points: "[[0,1],[60,4],[240,1],[0,0]]"
    end

    session[:step] ||= 0
    if session[:step] == 0
      set1
    end
    session[:step] += 1

    run_board

  end

  def run_board
    display_board
    @board.next_cycle
    session[:coordinates] = @board.coordinates
  end

  def display_board
    gray_points
    @board = Board.new
    session[:coordinates].each do |coordinate|
      @board.add_cell Coordinate.new(*coordinate)
    end
  end

  def gray_points
    @gray_points = []
    (1..15).each do |n|
      (1..15).each do |m|
        @gray_points << Coordinate.new(0,n,60,m)
      end
    end
  end

end
