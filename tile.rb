class Tile
  attr_accessor :bomb, :flag, :value, :revealed

  def initialize(bomb = false, flag = false, value = 0, revealed = false)
    @bomb = bomb
    @flag = flag
    @value = value
    @revealed = revealed
  end

  def inspect
     if self.dormant?
       "■"
     elsif self.flagged?
       "⚑"
     elsif self.bombed?
       "✹"
     elsif self.flipped?
       self.value.to_s
     end
  end

  def dormant?
    !self.revealed && !self.flag
  end

  def flagged?
    self.flag
  end

  def bombed?
    self.bomb && self.revealed
  end

  def flipped?
    !self.bomb && self.revealed
  end

end
