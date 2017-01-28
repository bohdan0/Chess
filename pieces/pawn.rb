require_relative 'move_modules/stepping_piece'
require_relative 'piece'

class Pawn < Piece
  include SteppingPiece

  def move_dirs
    result = []
    if @color == :black
      result << [1, 0] if @board[add_pos(@pos, [1, 0])].is_a?(NullPiece)
      result << [2, 0] if @pos[0] == 1 && !result.empty? # first move
    else
      result << [-1, 0] if @board[add_pos(@pos, [-1, 0])].is_a?(NullPiece)
      result << [-2, 0] if @pos[0] == 6 && !result.empty? # first move
    end

    result + attack_dirs
  end

  def attack_dirs
    result = []
    result += (@color == :black ? [[1, -1], [1, 1]] : [[-1, -1], [-1, 1]])

    result.reject do |dir|
      att_pos = add_pos(@pos, dir)
      @board.in_bounds?(att_pos) &&
      (@board[att_pos].is_a?(NullPiece) ||
       @board[att_pos].color == @color)
    end
  end

  def to_s
    code = "\u265F"
    super(code)
  end
end