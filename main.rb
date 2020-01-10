require 'matrix'

def main
  g = Nisenyoujuhachi.new
  g.game_init
  g.print_field
  g.game_loop
end

class Nisenyoujuhachi
  FIELD_SIZE = 4
  def initialize
    @field = Array.new(4) { Array.new(4, 0) }
    @r = Random.new
  end

  def game_init
    2.times { place_number }
  end

  def game_loop
    loop do
      puts 'input h or j or k or l'
      print '==> '
      str = gets.chomp

      case str
      when 'h' then
        tmp_field = move_tiles(@field)
      when 'j' then
        tmp_field = move_tiles(@field.transpose.map(&:reverse))
        tmp_field = tmp_field.map(&:reverse).transpose
        @field = tmp_field
      when 'k' then
        tmp_field = move_tiles(@field.transpose)
        tmp_field = tmp_field.transpose
        @field = tmp_field
      when 'l' then
        tmp_field = move_tiles(@field.map(&:reverse))
        tmp_field = tmp_field.map(&:reverse)
        @field = tmp_field
      when 'quit' then
        return
      else
        puts 'invalid input'
        next
      end

      place_number
      print_field
    end
  end

  def move_tiles(tmp_field)
    tmp_field = left_move(tmp_field)
    tmp_field = left_add(tmp_field)
    tmp_field = left_move(tmp_field)
    tmp_field
  end

  def left_add(tmp_field)
    for row in 0..FIELD_SIZE - 1
      for column in 1..FIELD_SIZE - 1
        tmp = tmp_field[row][column]
        if tmp_field[row][column - 1] == tmp
          tmp_field[row][column - 1] += tmp
          tmp_field[row][column] = 0
        end
      end
    end
    tmp_field
  end

  def left_move(tmp_field)
    for row in 0..FIELD_SIZE - 1
      tmp_vector = tmp_field[row]
      for column in 1..FIELD_SIZE - 1
        for i in 0..column - 1
          if tmp_vector[i..column-1].count(0) == tmp_vector[i..column-1].length
            tmp_vector[i] = tmp_vector[column]
            tmp_vector[column] = 0
          end
        end
      end
      tmp_field[row] = tmp_vector
    end
    tmp_field
  end

  def print_field
    for i in 0..FIELD_SIZE - 1
      for j in 0..FIELD_SIZE - 1
        print sprintf("%5d ", @field[i][j])
      end
      puts ""
    end
  end

  def place_number
    refresh_zero_index_list
    if @zero_index_list.size != 0
      r = rand(@zero_index_list.size)
      x = @zero_index_list[r][0]
      y = @zero_index_list[r][1] 

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
