require_relative './tile.rb'
require 'colorize'
require 'colorized_string'

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
    header = "  0 1 2 3 4 5 6 7 8 ".colorize(:cyan).colorize(:background => :black)
    puts header
    @grid.each do |row|
      line = "#{@grid.index(row)} ".colorize(:cyan)
      row.each do |tile|
        tile = (tile.bombed?) ? tile.inspect.colorize(:red) : tile.inspect.colorize(:green)
        line << "#{tile} "
      end
      puts line.colorize(:background => :black)
    end
  end

  def place_bombs
      bomb_count = 0
      until bomb_count == 10
        x = rand(9)
        y = rand(9)
          @grid[x][y].bomb = true unless @grid[x][y].bomb == true
          bomb_count += 1
          @bomb_positions << [x, y]
      end
  end

  def neighboring(pos)
    neighbors = []
    row = pos[0]
    col = pos[1]
    neighbors << [row - 1, col]
    neighbors << [row + 1, col]
    neighbors << [row - 1, col + 1]
    neighbors << [row, col + 1]
    neighbors << [row + 1, col + 1]
    neighbors << [row - 1, col - 1]
    neighbors << [row, col - 1]
    neighbors << [row + 1, col - 1]
    neighbors.select { |neighbor| neighbor.first.between?(0, 8) && neighbor.last.between?(0, 8) }
  end

  def assign_values
    @bomb_positions.each do |pos|
      neighboring(pos).each { |tile| self[tile].value += 1 }
    end
  end

end

if __FILE__ == $0
  b = Board.new
  b.place_bombs
  b.render
end
