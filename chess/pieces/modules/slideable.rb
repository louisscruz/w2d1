module Slideable
  LATERAL = [
    [0, -1],
    [-1, 0],
    [0, 1],
    [1, 0]
  ]
  DIAGONAL = [
    [-1, -1],
    [1, 1],
    [-1, 1],
    [1, -1]
  ]

  def moves
    generate_all_moves(move_directions)
  end

  def generate_all_moves(directions)
    #take position
    moves = []

    directions.each do |direction|
      new_x = @position.first + direction.first
      new_y = @position.last + direction.last
      new_position = [new_x, new_y]
      blocked = false
      while self.class.in_bounds?(new_position) && !blocked
        # Make sure piece can't move past blocking pieces, and allow for taking of piece
        if occupied_position?(new_position)
          blocked = true
          next if same_color?(new_position)
        end
        moves << new_position
        new_x = new_position.first + direction.first
        new_y = new_position.last + direction.last
        new_position = [new_x, new_y]
      end
    end
    moves
  end

end
