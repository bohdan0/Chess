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
    copy = @board.copy
    copy.move_piece!(@pos, next_pos)
    copy.in_check?(@color)
  end

  def to_s(uni = nil)
    return '  ' if uni.nil?
    "#{uni.encode('utf-8')} "
  end

  def add_pos(prev, dir)
    [prev[0] + dir[0], prev[1] + dir[1]]
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
    code = "\u265A"
    super(code)
  end
end

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
