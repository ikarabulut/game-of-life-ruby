require_relative './world.rb'

class Cell
  attr_reader :x, :y
  attr_accessor :status

  def initialize(x, y)
    @x = x
    @y = y
    @status = 0
  end

  def alive?
   @status == 1
  end

  def revive
    @status = 1
  end

  def kill
    @status = 0
  end

  def to_s
    @status
  end

end