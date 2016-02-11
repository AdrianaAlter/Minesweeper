class Tile
  attr_accessor :bomb, :flag, :value

  def initialize(bomb = false, flag = false, value = 0)
    @bomb = bomb
    @flag = flag
    @value = value
  end

  def inspect
    # if self.bomb == false && self.flag == false
      "_"
    # elsif self.flag == true
    #   "F"
    # # else
    # #   "*"
    # end


  end

end
