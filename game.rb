require_relative "./board.rb"
require_relative "./tile.rb"

class Game

  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def play
    setup
    play_turn
  end

  def display
    @board.render
  end

  def play_turn
    coordinates = get_coordinates
    choice = get_choice
    handle_input(coordinates, choice)
    display
  end

  def get_coordinates
    p "Choose coordinates (row, column)."
    coordinates = gets.chomp.split(", ").map { |el| el.to_i }
    if valid_coordinates?(coordinates)
      coordinates
    else
      get_coordinates
    end
  end

  def get_choice
    p "Flag or Reveal (F/R)"
    choice = gets.chomp
    if choice == "F" || choice == "R"
      choice
    else
      get_choice
    end
  end

  def handle_input(coordinates, choice)
    if is_bomb?(coordinates)
      if choice == "F"
        flag(coordinates)
      elsif choice == "R"
        game_lost
      end
    else
      if choice == "F"
        flag(coordinates)
      elsif choice == "R"
        show_values
      end
    end

  end

  def valid_coordinates?(coordinates)
    coordinates.length == 2 && coordinates.all? {|e| e.between?(0, 8)}
  end

  def is_bomb?(coord)
    @board.bomb_positions.include?(coordinates)
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
