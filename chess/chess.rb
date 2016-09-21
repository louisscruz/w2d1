require_relative "player/computer_player"
require_relative "player/human_player"
require_relative "board"
require_relative "display"

class Chess
  def initialize(board = Board.new)
    @board = board
    @display = Display.new(@board)
    player_one = HumanPlayer.new(:white, @display)
    player_two = HumanPlayer.new(:black, @display)
    @players = [player_one, player_two]
    @current_player = @players.first
  end

  def play
    @display.render
    until won?
      p @current_player
      begin
        @current_player.make_move
        # @display.get_input
      rescue
        p "Invalid move Douche!!!"
        retry
      end
      swap_turn
      @display.render
    end
    p "SOMEONE WON!"
  end

  private

  def swap_turn
    current_idx = @players.find_index(@current_player)
    @current_player = @players[(current_idx + 1) % 2]
  end

  def won?
    @board.checkmate?(:white)
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Chess.new
  game.play
end
