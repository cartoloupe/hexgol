class ShellController < ApplicationController

  def shell
    @counter += 1
    @board = [[0,1],[60,4]]
    @display = @board
  end

end
