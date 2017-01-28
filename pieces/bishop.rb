require_relative 'move_modules/sliding_piece'
require_relative 'piece'

class Bishop < Piece
  include SlidingPiece

  def move_dirs
    diagonals
  end

  def to_s
    code = "\u265D"
    super(code)
  end
end