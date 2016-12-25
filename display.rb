require "colorize"
require_relative "cursor"

class Display

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
    @storage = nil
  end

  def render
    loop do
      system('clear')
      get_moves
      show
      @cursor.get_input
    end
  end

  def show
    @board.grid.each_with_index do |line, row_idx|
      line.each_with_index do |piece, col_idx|
        if [row_idx, col_idx] == @cursor.cursor_pos
          print piece.to_s.colorize(background: :blue)
        elsif @storage && @storage.include?([row_idx, col_idx])
          print piece.to_s.colorize(background: :red)
        else
          print piece.to_s
        end
      end
      puts
    end
  end

  def get_moves
    if @cursor.selected && @board[@cursor.cursor_pos].is_a?(NullPiece)
      @storage ||= nil
    elsif @cursor.selected
      @storage ||= @board[@cursor.cursor_pos].valid_moves
    else
      @storage = nil
    end
  end

end
