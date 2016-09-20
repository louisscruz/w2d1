require_relative "piece"
require_relative "modules/slideable"

class Bishop < Piece
  include Slideable
  attr_reader :symbol

  def initialize(color, board, position)
    @symbol = color == :white ? "♗" : "♝"
    super
  end

  def move_directions
    Slideable::DIAGONAL
  end
end
