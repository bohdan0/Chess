require_relative 'move_modules/stepping_piece'
require_relative 'piece'

class King < Piece
  include SteppingPiece

  def move_dirs
    horizontal + diagonals
  end

  def to_s
    code = "\u265A"
    super(code)
  end
end