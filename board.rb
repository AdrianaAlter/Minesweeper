class Board

  attr_reader :grid

  def initalize(grid)
    @grid = Array.new(9) { Array.new(9) }
  end

  def random_position
    x = (0..9).to_a.sample
    y = (0..9).to_a.sample
    grid[x][y]
  end

  def place_tile

  end
