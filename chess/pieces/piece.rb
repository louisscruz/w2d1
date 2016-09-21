class Piece
  attr_reader :color
  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
  end

  def update_position(pos)
    @position = pos
  end

  def to_s
    self.symbol
  end

  def self.in_bounds?(position)
    x, y = position
    (0..7).to_a.include?(x) && (0..7).to_a.include?(y)
  end

  def occupied_position?(position)
    @board[position].is_a?(Piece)
  end

  def same_color?(position)
    !@board[position].is_a?(NullPiece) && @board[position].color == @color
  end

  def valid_moves
    valids =[]
    moves.each do |move|
      valids << move unless move_into_check?(move)
    end
    valids
  end

  def move_into_check?(position)
    board_copy = @board.dup
    board_copy.move(@position, position)
    board_copy.in_check?(@color)
  end
end
