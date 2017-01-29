require "colorize"
require_relative "cursor"

class Display
attr_accessor :cursor, :notifications, :current_player

  def initialize(board, current_player)
    @board = board
    @cursor = Cursor.new([7, 0], board)
    @current_player = current_player
    @notifications = ''
  end

  def render(from = nil)
    system('clear')
    puts @notifications
    show(from)
    @cursor.get_input
  end

  def show(from)
    @board.grid.each_with_index do |line, row_idx|
      line.each_with_index do |piece, col_idx|
        print piece.to_s.colorize(colors([row_idx, col_idx], from))
      end
      puts
    end
  end

  def colors(pos, from)
    color = @board[pos].color == :white ? :light_red : :black

    if @cursor.cursor_pos == pos
      { background: :light_blue, color: color }
    elsif from && @current_player.color  == @board[from].color &&
          @board[from].valid_moves.include?(pos)

      if attack_move?(pos)
        { background: :red, color: color }
      else
        { background: :light_yellow, color: color }
      end
    elsif (pos[0] + pos[1]).even?
      { background: :white, color: color }
    else
      { background: :light_grey, color: color }
    end
  end

  def attack_move?(pos)
    !@board[pos].is_a?(NullPiece) &&
    @board[pos].color != @current_player.color 
  end
end
