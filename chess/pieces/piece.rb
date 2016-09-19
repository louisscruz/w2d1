class Piece
  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
  end

  def update_position(pos)
    @position = pos
  end
end
