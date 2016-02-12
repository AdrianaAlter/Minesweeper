class Tile
  attr_accessor :bomb, :flag, :value, :revealed

  def initialize(bomb = false, flag = false, value = 0, revealed = false)
    @bomb = bomb
    @flag = flag
    @value = value
    @revealed = revealed
  end

  def inspect
     if self.revealed == false && self.flag == false
       "_"
     elsif self.flag == true
       "F"
     elsif self.bomb == true && self.revealed == true
       "*"
     elsif self.bomb == false && self.revealed == true
       self.value
     end
  end




    #GAME LOST
    # if self.bomb == true
    #   "*"
    # else
    #   self.value
    # end




end
