require "colorize"
require_relative "cursor"
require_relative "board"

class Display
  def initialize(board = Board.new)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    system('clear')
    board = ""
    @board.grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        tile = " " + piece.to_s.black + " "
        if @cursor.selected == [i, j] || (!@cursor.selected && [i, j] == @cursor.cursor_pos)
          board += tile.on_green
        elsif @cursor.selected && [i, j] == @cursor.cursor_pos
          board += tile.on_yellow
        elsif (2 + i + j) % 2 == 0
          board += tile.on_light_white
        else
          board += tile.on_white
        end
      end
      board += "\n"
    end
    print board
  end

  def get_input
    @cursor.get_input
  end
end
