require_relative "piece"

class Pawn < Piece
  attr_reader :symbol

  def initialize(color, board, position)
    @symbol = color == :white ? "♙" : "♟"
    super
  end

  def moves
    moves = []

    direction = @color == :white ? -1 : 1
    new_move = [@position.first + direction, @position.last]
    moves << new_move
    if is_in_first_row?
      two_step = [@position.first + (2 * direction), @position.last]
      moves << two_step
    end

    diagonal_one = [@position.first + direction, @position.last - 1]
    diagonal_two = [@position.first + direction, @position.last + 1]

    [diagonal_one, diagonal_two].each do |diagonal|
      moves << diagonal if @board.is_enemy?(diagonal, @color)
    end

    moves
  end

  private
  def is_in_first_row?
    @position.first == 1 || @position.first == 6
  end


end
