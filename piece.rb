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
  # POSITIONS = [
  #     [- 1, - 1],
  #     [- 1, 0],
  #     [- 1, 1],
  #     [0, - 1],
  #     [0, 1],
  #     [1, - 1],
  #     [1, 0],
  #     [1, 1]
  #   ]


end

class Knight < Piece
  include SteppingPiece
  # POSITIONS = [
  #     [- 2, 1],
  #     [- 1, 2],
  #     [1, 2],
  #     [2, 1],
  #     [2, - 1],
  #     [1, - 2],
  #     [- 1, - 2],
  #     [- 2, - 1]
  #   ]
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
end
