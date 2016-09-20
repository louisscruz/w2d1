require_relative "piece"
require_relative "modules/slideable"

class Rook < Piece
  include Slideable
  attr_reader :symbol

  def initialize(color, board, position)
    @symbol = color == :white ? "♖" : "♜"
    super
  end
end
