require_relative './tile.rb'

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(9) { Array.new(9) {Tile.new} }
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  # def random_position
  #   row = (0..9).to_a.sample
  #   column = (0..9).to_a.sample
  #   [row, column]
  # end
  #
  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def render
    @grid.each {|row| puts "#{row}" }
  end


  def place_bombs
      bomb_count = 0

      until bomb_count == 10
        x = rand(9)
        y = rand(9)

        unless @grid[x][y].bomb == true
          @grid[x][y].bomb = true
          bomb_count += 1
        end
      end
      p bomb_count
  end

end


# grid = Array.new(9) { Array.new(9) }
# p grid

if __FILE__ == $0
  b = Board.new
  b.place_bombs
  b.render 
end
