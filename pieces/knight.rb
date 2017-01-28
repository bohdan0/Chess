require_relative 'move_modules/stepping_piece'
require_relative 'piece'

class Knight < Piece
  include SteppingPiece

  def move_dirs
    knight
  end

  def to_s
    code = "\u265E"
    super(code)
  end
end