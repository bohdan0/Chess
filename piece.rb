require 'singleton'
require_relative './sliding_piece.rb'
require_relative './stepping_piece.rb'

class Piece

  def initialize(pos, board)
    @pos = pos
    @board = board
  end

end

class NullPiece < Piece
  include Singleton

  def initialize
  end
end

class King < Piece
  include SteppingPiece
  POSITIONS = [
      [- 1, - 1],
      [- 1, 0],
      [- 1, 1],
      [0, - 1],
      [0, 1],
      [1, - 1],
      [1, 0],
      [1, 1]
    ]

  def move_dirs(board)
    # moves.select { |move| board[move].is_a?(NullPiece) }
  end

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
  POSITIONS = [
      [- 1, - 1],
      [- 1, 0],
      [- 1, 1],
      [0, - 1],
      [0, 1],
      [1, - 1],
      [1, 0],
      [1, 1]
    ]

end

class Bishop < Piece
  include SlidingPiece
  # POSITIONS = [
  #     [- 1, - 1],
  #     [- 1, 1],
  #     [1, - 1],
  #     [1, 1]
  #   ]
end

class Rook < Piece
  include SlidingPiece
  # POSITIONS = [
  #     [- 1, 0],
  #     [0, - 1],
  #     [0, 1],
  #     [1, 0],
  #   ]
end

class Pawn < Piece
end
