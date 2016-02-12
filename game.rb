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
    until @game_lost == true || @revealed_count == 71
      play_turn
    end
    if @game_lost == false
      puts "YOU WON!!!"
      reveal_all
      display
    end
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
    p "Flag or Reveal or Unflag (F/R/U)"
    choice = gets.chomp
    if choice == "F" || choice == "R" || choice == "U"
      choice
    else
      get_choice
    end
  end

  def flag_toggle(coordinates)
    @board[coordinates].flag = @board[coordinates].flag == true ? false : true
  end

  def reveal(coordinates)
    @board[coordinates].revealed = true
  end


  def handle_input(coordinates, choice)
    if is_bomb?(coordinates)
      if choice == "F" || choice == "U"
        flag_toggle(coordinates)
      else
        reveal_all
        @game_lost = true
        p "YOU LOSE!!!"
      end
    else
      if choice == "F" || choice == "U"
        flag_toggle(coordinates)
      elsif choice == "R"
        reveal(coordinates)
        @revealed_count += 1
        if @board[coordinates].value == 0
          @board.neighboring(coordinates).each { |neighbor| handle_input(neighbor, "R") unless @board[neighbor].revealed == true }
        end

      end
    end

  end

  def valid_coordinates?(coordinates)
    coordinates.length == 2 && coordinates.all? {|e| e.between?(0, 8)}
  end

  def is_bomb?(coord)
    @board.bomb_positions.include?(coord)
  end

  def setup
    @board.place_bombs
    @board.assign_values
    display
  end

  def reveal_all
      @board.grid.each do |row|
        row.each do |tile|
          tile.revealed = true
        end
      end
  end


end




if __FILE__ == $0
  a = Game.new
  a.play
end
