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
    #raise "Invalid move" if self[start].move_into_check?(end_pos)
    self[start], self[end_pos] = self[end_pos], self[start]
    self[end_pos].update_position(end_pos)
    self[start].update_position(start) unless self[start].is_a?(NullPiece)
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

  def is_enemy?(position, color)
    piece = self[position]
    !piece.is_a?(NullPiece) && piece.color != color
  end

  def in_check?(color)
    king_position = find_king_position(color)
    enemy_pieces(color).each do |enemy|
      # p "#{enemy.class} has moves: #{enemy.moves}"
      return true if enemy.moves.include?(king_position)
    end
    false
  end

  def checkmate?(color)
    #still in construction
    in_check?(color) && self[find_king_position(color)].valid_moves.length == 0
  end

  def dup
    Marshal.load(Marshal.dump(self))
    # board = Board.new
    # @grid.each_with_index do |row, i|
    #   row.each_with_index do |tile, j|
    #     board[[i, j]] = tile
    #   end
    # end
    # board
  end

  private
  def set_pieces
    (0..7).each { |i| @grid[1][i] = Pawn.new(:black, self, [1, i]) }
    (0..7).each { |i| @grid[6][i] = Pawn.new(:white, self, [6, i]) }
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

  def enemy_pieces(color)
    enemies = []
    @grid.each do |row|
      row.each do |tile|
        if !tile.is_a?(NullPiece) && tile.color != color
          enemies << tile
        end
      end
    end
    enemies
  end

  def find_king_position(color)
    king_position = []
    @grid.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        if tile.is_a?(King) && tile.color == color
          king_position = [i, j]
        end
      end
    end
    king_position
  end
end
