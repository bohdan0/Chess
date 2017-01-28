require_relative 'move_modules/sliding_piece'
require_relative 'piece'

class Rook < Piece
  include SlidingPiece

  def move_dirs
    horizontal
  end

  def to_s
    code = "\u265C"
    super(code)
  end
end