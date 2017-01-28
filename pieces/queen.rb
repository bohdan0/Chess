require_relative 'move_modules/sliding_piece'
require_relative 'piece'

class Queen < Piece
  include SlidingPiece

  def move_dirs
    horizontal + diagonals
  end

  def to_s
    code = "\u265B"
    super(code)
  end
end