require_relative 'piece'

class Board
  attr_reader :grid
  def self.set_up_board(grid)
    grid.map.with_index do |line, line_idx|
      line.map do |el|
        [0,1,6,7].include?(line_idx) ? Piece.new : NullPiece.new
      end
    end
  end

  def initialize
    grid = Array.new(8) { Array.new(8) }
    @grid = Board.set_up_board(grid)
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end

  def in_bounds?(pos)
    pos.all? { |el| el.between?(0, 7) }
  end

  def move_piece(start_pos, end_pos)
    if self[start_pos].is_a?(NullPiece)
      raise ArgumentError.new('Start position empty')
    end
    unless in_bounds?(end_pos)
      raise ArgumentError.new('You\'re out of bounds')
    end

    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.new
  end

end
