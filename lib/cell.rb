require_relative './world.rb'

class Cell
  attr_reader :x, :y
  attr_accessor :status

  def initialize(x, y, status)
    @x = x
    @y = y
    @status = status
  end

  def to_s
    @status == "alive" ? 1 : 0
  end

end