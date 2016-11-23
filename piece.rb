require 'singleton'
require_relative './sliding_piece.rb'
require_relative './stepping_piece.rb'
require_relative './board.rb'
class Piece

  attr_accessor :pos, :board, :color

  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(move)
    board_dup = Board.new
    board_dup.grid = my_dup

    prev = @pos
    board_dup[move] = self
    self.pos = move
    board_dup[prev] = NullPiece.instance

    flag = board_dup.in_check?(@color) ? true : false
    self.pos = prev

    flag
  end

  def my_dup(b = @board.grid)
    result = []
    b.each do |el|
      if el.is_a?(Array)
        result << my_dup(el)
      else
        result << el
      end
    end

    result
  end

  def to_s(uni = nil)
    return ' ' if uni.nil?
    uni.encode('utf-8')
  end


end

class NullPiece < Piece
  include Singleton

  def initialize
  end
end

class King < Piece
  include SteppingPiece

  def move_dirs
    horizontal + diagonals
  end

  def to_s
    code = @color == :black ? "\u2654" : "\u265A"
    super(code)
  end
end

class Knight < Piece
  include SteppingPiece

  def to_s
    code = @color == :black ? "\u265E" : "\u2658"
    super(code)
  end
end

class Queen < Piece
  include SlidingPiece

  def move_dirs
    horizontal + diagonals
  end

  def to_s
    code = @color == :black ? "\u265B" : "\u2655"
    super(code)
  end
end

class Bishop < Piece
  include SlidingPiece

  def move_dirs
    diagonals
  end

  def to_s
    code = @color == :black ? "\u265D" : "\u2657"
    super(code)
  end
end

class Rook < Piece
  include SlidingPiece

  def move_dirs
    horizontal
  end

  def to_s
    code = @color == :black ? "\u265C" : "\u2656"
    super(code)
  end
end

class Pawn < Piece
  include SteppingPiece

  def moves
    result = []
    move_dirs.each do |dir|
      position = add_pos(@pos, dir)
      result << position if valid_move?(position) # || attack?(position)
    end

    result
  end

  # Fix later
  # def attack?(position)
  #   !board[position].is_a?(NullPiece) &&
  #   @board.in_bounds?(position) && board[position].color != @color
  # end

  def move_dirs
    if color == :black
      [[1, 0]]
    else
      [[-1, 0]]
    end
  end

  def to_s
    code = @color == :black ? "\u265F" : "\u2659"
    super(code)
  end
end
