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

  def move_into_check?(next_pos)
    board_dup = Board.new
    board_dup.grid = @board.my_dup

    piece_copy = self.copy(self.pos, board_dup, self.color)
    prev_pos = @pos

    board_dup[next_pos] = piece_copy
    piece_copy.pos = next_pos
    board_dup[prev_pos] = NullPiece.instance

    board_dup.in_check?(@color) ? true : false
  end

  def to_s(uni = nil)
    return ' ' if uni.nil?
    uni.encode('utf-8')
  end

  def copy(pos, board, color)
    if self.is_a?(NullPiece)
      NullPiece.instance
    else
      self.class.new(pos, board, color)
    end
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
    code = @color == :black ? "\u265A" : "\u2654"
    super(code)
  end
end

class Knight < Piece
  include SteppingPiece

  def move_dirs
    knight
  end

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
