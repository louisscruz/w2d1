require_relative "piece"

class Pawn < Piece
  attr_reader :symbol

  def initialize(color, board, position)
    @symbol = color == :white ? "♙" : "♟"
    super
  end
end
