require_relative "piece"
require_relative "modules/slideable"


class Queen < Piece
  include Slideable
  attr_reader :symbol

  def initialize(color, board, position)
    @symbol = color == :white ? "♕" : "♛"
    super
  end

  def move_directions
    Slideable::DIAGONAL + Slideable::LATERAL
  end
end
