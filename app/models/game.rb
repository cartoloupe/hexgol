class Game < ActiveRecord::Base

  def initialize
    @counter ||= 0
  end

end
