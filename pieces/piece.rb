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