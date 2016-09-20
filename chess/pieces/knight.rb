require_relative "piece"
require_relative "modules/stepable"


class Knight < Piece
  include Stepable
  attr_reader :symbol

  def initialize(color, board, position)
    @symbol = color == :white ? "♘" : "♞"
    super
  end

  def move_directions
    Stepable::L_MOVE
  end
end
