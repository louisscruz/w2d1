require_relative "piece"
require_relative "modules/slideable"


class Queen < Piece
  include Slideable
end
