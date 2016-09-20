require_relative "player/computer_player"
require_relative "player/human_player"
require_relative "board"
require_relative "display"

class Chess
  def initialize(board = Board.new)
    @board = board
    @display = Display.new
  end

  def play
    @display.loop
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Chess.new
  game.play
end
