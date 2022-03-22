require_relative './cell.rb'

class World
  attr_reader :cells, :columns, :rows

  def initialize(columns,rows)
    @columns = columns
    @rows = rows
    @cells = []
    rows.times do |x|
      @cells.push([])
      columns.times do |y|
        @cells[x].push( Cell.new(x, y, self))
      end
    end

  end

  def get_cell(x,y)
    @cells[x][y]
  end


end

