require_relative "piece"
require_relative "modules/slideable"

class Rook < Piece
  include Slideable
end
