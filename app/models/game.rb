require 'hex.rb'
class Game < ActiveRecord::Base

  def initialize
    @counter ||= 0
    @board = Board.new
  end

end
