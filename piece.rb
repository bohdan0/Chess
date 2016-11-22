require 'singleton'
require_relative './sliding_piece.rb'
require_relative './stepping_piece.rb'

class Piece

  attr_accessor :pos, :board, :color

  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
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
end

class Knight < Piece
  include SteppingPiece

  def move_dirs
    knight
  end
end

class Queen < Piece
  include SlidingPiece

  def move_dirs
    horizontal + diagonals
  end
end

class Bishop < Piece
  include SlidingPiece

  def move_dirs
    diagonals
  end
end

class Rook < Piece
  include SlidingPiece

  def move_dirs
    horizontal
  end
end

class Pawn < Piece
  include SteppingPiece

  def moves
    result = []
    move_dirs.each do |dir|
      postion = add_pos(pos, dir)
      result << postion if valid_move?(postion) || attack?(postion)
    end

    result
  end

  def attack?(position)
    !board[position].is_a?(NullPiece) && board[position].color != color
  end

  def move_dirs
    if color == black
      [[1, 0], [1, -1], [1, 1]]
    else
      [[-1, 0], [-1, -1], [-1, 1]]
    end
  end

end
