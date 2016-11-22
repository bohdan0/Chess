require_relative 'piece'

class Board
  attr_reader :grid
  def self.set_up_board(grid)
    grid.map.with_index do |line, line_idx|
      # line.map do |el|
      case line_idx
      when 0, 7
        create_first_line(line_idx)
      when 1, 6
        create_pawns_line(line_idx)
      else
        create_null_line
      # [0,1,6,7].include?(line_idx) ? Piece.new : NullPiece.new
      end
      # end
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
    self[start_pos] = NullPiece.instance
  end

  # private

  def self.create_null_line
    result = []
    8.times { result << NullPiece.instance }

    result
  end

  def self.create_pawns_line(line)
    result = []
    8.times { |i| result << Pawn.new([line, i], self) }

    result
  end

  def self.create_first_line(line)
    result = []
    result << Rook.new([line, 0], self)
    result << Knight.new([line, 1], self)
    result << Bishop.new([line, 2], self)
    if line.zero?
      result << King.new([line, 3], self)
      result << Queen.new([line, 4], self)
    else
      result << Queen.new([line, 3], self)
      result << King.new([line, 4], self)
    end
    result << Bishop.new([line, 5], self)
    result << Knight.new([line, 6], self)
    result << Rook.new([line, 7], self)

    result
  end

end
