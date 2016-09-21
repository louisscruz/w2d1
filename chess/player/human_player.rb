require_relative "player"

class HumanPlayer < Player
  def initialize(color, display)
    super
  end

  def make_move
    @display.get_input
  end
end
