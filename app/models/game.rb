require 'hex.rb'
class Game < ActiveRecord::Base

  def initialize
    @board = Board.new
  end

end
