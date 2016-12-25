require "colorize"
require_relative "cursor"

class Display
attr_accessor :cursor, :notifications, :current_player

  def initialize(board)
    @board = board
    @cursor = Cursor.new([7, 0], board)
    @current_player = :white
    @notifications = ''
  end

  def render(from = nil)
    system('clear')
    puts @notifications
    show(from)
    @cursor.get_input
  end

  def show(from = nil)
    @board.grid.each_with_index do |line, row_idx|
      line.each_with_index do |piece, col_idx|
        print piece.to_s.colorize(colors(row_idx, col_idx, from))
      end
      puts
    end
  end

  def colors(i, j, from = nil)
    color = (@board[[i, j]].color == :white) ? :light_red : :black
    if @cursor.cursor_pos == [i, j]
      { background: :light_blue, color: color }
    elsif from && @current_player == @board[from].color &&
          @board[from].valid_moves.include?([i, j])

      { background: :light_yellow, color: color }
    elsif (i + j).even?
      { background: :white, color: color }
    else
      { background: :light_grey, color: color }
    end
  end
end
