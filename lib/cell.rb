require_relative './world.rb'
require 'world'

class Cell
  attr_reader :x, :y
  attr_accessor :status

  def initialize(x, y, status)
    @x = x
    @y = y
    @status = status
  end

end