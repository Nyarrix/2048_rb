require 'matrix'

def main
  g = Nisenyoujuhachi.new
  g.print_field
end

class Nisenyoujuhachi
  def initialize
    @field = Matrix.zero(4, 4)
  end

  def print_field
    for i in 0..@field.row_size - 1
      for j in 0..@field.column_size - 1
        print sprintf("%5d ", @field[i, j])
      end
        puts ""
    end
  end

  attr_accessor :field
end

if __FILE__ == $0
  main
end
