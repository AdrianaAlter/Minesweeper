require_relative "./board.rb"
require_relative "./tile.rb"

class Game

  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def play
    setup
  end

  def display
    @board.render
  end

  def play_turn
  end

  def setup
    @board.place_bombs
    display
  end

end




if __FILE__ == $0
  a = Game.new
  a.play
end
