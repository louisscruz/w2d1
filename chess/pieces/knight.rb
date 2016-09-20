require_relative "piece"
require_relative "modules/stepable"


class Knight < Piece
  include Stepable
  attr_reader :symbol

  def initialize(color, board, position)
    @symbol = color == :white ? "♘" : "♞"
    super
  end
end
