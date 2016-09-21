module Stepable
  CIRCULAR = (-1..1).to_a.product((-1..1).to_a) - [[0,0]]

  L_MOVE = [
    [-2, -1],
    [-2, 1],
    [-1, -2],
    [-1, 2],
    [1, -2],
    [1, 2],
    [2, -1],
    [2, 1]
  ]

  def moves
    generate_all_moves(move_directions)
  end

  def generate_all_moves(directions)
    moves = []
    directions.each do |direction|
      new_x = @position.first + direction.first
      new_y = @position.last + direction.last
      new_position = [new_x, new_y]
      next unless self.class.in_bounds?(new_position)
      unless same_color?(new_position)
        moves << new_position
      end
    end
    moves
  end
end
