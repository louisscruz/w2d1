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
      row.each_with_index do |tile, j|
        tile = " " * 3
        if [i, j] == @cursor.cursor_pos
          board += tile.on_green
        elsif (2 + i + j) % 2 == 0
          board += tile.on_white
        else
          board += tile.on_light_black
        end
      end
      board += "\n"
    end
    print board
  end

  def loop
    while true
      render
      @cursor.get_input
    end
  end
end
