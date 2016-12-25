require "colorize"
require_relative "cursor"

class Display
attr_accessor :cursor, :notifications

  def initialize(board)
    @board = board
    @cursor = Cursor.new([7, 0], board)
    @notifications = ''
  end

  def render(from = nil, current_player)
    system('clear')
    puts @notifications
    show(from, current_player)
    @cursor.get_input
  end

  def show(from = nil, current_player)
    @board.grid.each_with_index do |line, row_idx|
      line.each_with_index do |piece, col_idx|
        if [row_idx, col_idx] == @cursor.cursor_pos
          print piece.to_s.colorize(background: :blue)
        elsif from && current_player == @board[from].color &&
              @board[from].valid_moves.include?([row_idx, col_idx])

          print piece.to_s.colorize(background: :yellow)
        else
          print piece.to_s
        end
      end
      puts
    end
  end
end
