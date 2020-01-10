require 'matrix'

def main
	g = Nisenyoujuhachi.new
	g.game_init
	g.print_field
end

class Nisenyoujuhachi
	FIELD_SIZE = 4
  def initialize
		@field = Array.new(4) { Array.new(4, 0) }
		@r = Random.new
  end

  def print_field
    for i in 0..FIELD_SIZE - 1
      for j in 0..FIELD_SIZE - 1
				print sprintf("%5d ", @field[i][j])
				# print @field[i, j]
      end
        puts ""
    end
  end

	def game_init
		2.times { place_number }
	end

	def place_number
		refresh_zero_index_list
		if @zero_index_list.size != 0
			r = rand(@zero_index_list.size)
			x = @zero_index_list[r][0]
			y = @zero_index_list[r][1] 
			puts("#{x} #{y}")

			@field[x][y] = generate_4_or_2
		end
	end

	def generate_4_or_2
		if @r.rand(4) == 0 # FIXME: magic number
			4
		else
			2
		end
	end

	def refresh_zero_index_list
		@zero_index_list = []
    for i in 0..FIELD_SIZE - 1
      for j in 0..FIELD_SIZE - 1
				if @field[i][j] == 0
					@zero_index_list.push([i, j])
				end
      end
    end
	end

  attr_accessor :field
end

if __FILE__ == $0
  main
end
