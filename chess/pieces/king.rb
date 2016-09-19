require_relative "piece"
require_relative "modules/stepable"

class King < Piece
  include Stepable
end
