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

  def moves
    if self.slideable?
      [[0,0],[1,1],[2,2]]
    elsif self.stepable?
      [[6,6],[5,5],[0,0]]
    else
      self.moves
    end
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
    @board[position].color == @color
  end
end
