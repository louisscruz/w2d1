require_relative "pieces/king"
require_relative "pieces/knight"
require_relative "pieces/pawn"
require_relative "pieces/bishop"
require_relative "pieces/rook"
require_relative "pieces/queen"
require_relative "pieces/null_piece"

class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(8) {Array.new(8) {NullPiece.instance}}
    set_pieces
  end

  def move(start, end_pos)
    raise "Empty cell" if self[start].is_a?(NullPiece)
    self[start], self[end_pos] = self[end_pos], self[start]
    raise "Invalid move" unless self[start].update_position(end_pos)
    self[end_pos].update_position(start)
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def in_bounds?(pos)
    (0..7).to_a.include?(pos.first) && (0..7).to_a.include?(pos.last)
  end

  private
  def set_pieces
    @grid[1].map! {|tile| Pawn.new(:black, self, [0, 0])}
    @grid[6].map! {|tile| Pawn.new(:white, self, [0, 0])}
    self[[0, 4]] = King.new(:black, self, [0, 4])
    self[[7, 3]] = King.new(:white, self, [7, 3])
    self[[0, 3]] = Queen.new(:black, self, [0, 3])
    self[[7, 4]] = Queen.new(:white, self, [7, 4])

    self[[0, 0]] = Rook.new(:black, self, [0, 0])
    self[[0, 7]] = Rook.new(:black, self, [0, 7])
    self[[7, 0]] = Rook.new(:white, self, [7, 0])
    self[[7, 7]] = Rook.new(:white, self, [7, 7])

    self[[0, 2]] = Bishop.new(:black, self, [0, 2])
    self[[0, 5]] = Bishop.new(:black, self, [0, 5])
    self[[7, 2]] = Bishop.new(:white, self, [7, 2])
    self[[7, 5]] = Bishop.new(:white, self, [7, 5])

    self[[0, 1]] = Knight.new(:black, self, [0, 1])
    self[[0, 6]] = Knight.new(:black, self, [0, 6])
    self[[7, 1]] = Knight.new(:white, self, [7, 1])
    self[[7, 6]] = Knight.new(:white, self, [7, 6])
  end
end
