require "colorize"
require_relative "cursor"
# require_relative "board"

class Display

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    while true
      show
      @cursor.get_input
    end
  end

  def show
    @board.grid.each_with_index do |line, row_idx|
      line.each_with_index do |piece, col_idx |
        if [row_idx, col_idx] == @cursor.cursor_pos
          print 'X'.colorize(:background => :blue) + " "
        else
          print piece.is_a?(NullPiece) ? '0 ' : '1 '
        end
      end
      puts
    end
  end

end
