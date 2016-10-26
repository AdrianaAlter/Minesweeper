require_relative "./board.rb"
require_relative "./tile.rb"

class Game

  attr_accessor :board, :game_lost, :revealed_count

  def initialize
    @board = Board.new
    @game_lost = false
    @revealed_count = 0
  end

  def play
    setup
    play_turn until (@game_lost == true || @revealed_count == 71)
    win if @game_lost == false
  end

  def setup
    @board.place_bombs
    @board.assign_values
    display
  end

  def win
    puts "YOU WIN!!!"
    reveal_all
    display
  end

  def lose
    reveal_all
    @game_lost = true
    puts "YOU LOSE!!!"
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
    puts "Choose coordinates (row column)."
    coordinates = gets.chomp.split(" ").map { |el| el.to_i }
    valid_coordinates?(coordinates) ? coordinates : get_coordinates
  end

  def get_choice
    puts "Flag or Reveal or Unflag (F/R/U)"
    choice = gets.chomp.upcase
    valid_choice?(choice) ? choice : get_choice
  end

  def flag_toggle(coordinates)
    @board[coordinates].flag = @board[coordinates].flag == true ? false : true
  end

  def handle_input(coordinates, choice)
    if is_bomb?(coordinates)
      choice != "R" ? flag_toggle(coordinates) : lose
    else
      choice != "R" ? flag_toggle(coordinates) : reveal(coordinates)
    end
  end

  def reveal(coordinates)
    @board[coordinates].revealed = true
    @revealed_count += 1
    if @board[coordinates].value == 0
      @board.neighboring(coordinates).each { |neighbor| handle_input(neighbor, "R") unless @board[neighbor].revealed == true }
    end
  end

  def valid_coordinates?(coordinates)
    coordinates.length == 2 && coordinates.all? {|e| e.between?(0, 8)}
  end

  def valid_choice?(choice)
    choice == "F" || choice == "R" || choice == "U"
  end

  def is_bomb?(coordinates)
    @board.bomb_positions.include?(coordinates)
  end

  def reveal_all
      @board.grid.each do |row|
        row.each { |tile| tile.revealed = true }
      end
  end

end

if __FILE__ == $0
  a = Game.new
  a.play
end
