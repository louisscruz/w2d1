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

  def in_bounds?(pos)
    (0..7).to_a.include?(pos.first) && (0..7).to_a.include?(pos.last)
  end
end
