require_relative './tile.rb'

class Board

  attr_accessor :grid, :bomb_positions

  def initialize
    @grid = Array.new(9) { Array.new(9) {Tile.new} }
    @bomb_positions = []
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def render
    header = "    0, 1, 2, 3, 4, 5, 6, 7, 8"
    puts header
    @grid.each_with_index { |row, idx| puts "#{idx}  #{row}" }
  end


  def place_bombs
      bomb_count = 0


      until bomb_count == 10
        x = rand(9)
        y = rand(9)

        unless @grid[x][y].bomb == true
          @grid[x][y].bomb = true
          bomb_count += 1
          @bomb_positions << [x, y]
        end
      end

  end

  def neighboring(pos)
    neighbors = []
      r = pos[0]
      c = pos[1]
      neighbors << [r - 1, c]
      neighbors << [r + 1, c]
      neighbors << [r - 1, c + 1]
      neighbors << [r, c + 1]
      neighbors << [r + 1, c + 1]
      neighbors << [r - 1, c - 1]
      neighbors << [r, c - 1]
      neighbors << [r + 1, c - 1]
      neighbors.select { |neighbor| neighbor.first.between?(0, 8) && neighbor.last.between?(0, 8) }
  end

  def assign_values
    @bomb_positions.each do |pos|
      neighboring(pos).each { |tile| self[tile].value += 1 }
    end

  end

end


# grid = Array.new(9) { Array.new(9) }
# p grid

if __FILE__ == $0
  b = Board.new
  b.place_bombs
  b.render
end
