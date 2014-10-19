class ShellController < ApplicationController

  def shell
    @board = [[0,1],[60,4]]
    @display = @board
  end

  def home
  end
end
