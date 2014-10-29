class ShellController < ApplicationController

  def shell
    if Round.any?
      round = Round.last
    else
      round = Round.create points: "[[0,1],[60,4],[240,1],[0,0]]"
    end


    @board = [[0,1],[60,4]]
    @display = @board
  end

end
