require_relative './piece'

class Board
  attr_accessor :grid

  def initialize
    @grid = set_up_board
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
    pos.all? { |idx| idx.between?(0, 7) }
  end

  def move_piece(start_pos, end_pos)
    unless in_bounds?(end_pos)
      raise ArgumentError.new('You\'re out of bounds')
    end

    if self[start_pos].is_a?(NullPiece)
      raise ArgumentError.new('Start position empty')
    end

    if self[start_pos].color == self[end_pos].color
      raise ArgumentError.new('Can\'t attack same color pieces')
    end

    self[end_pos] = self[start_pos]
    self[end_pos].pos = end_pos
    self[start_pos] = NullPiece.instance
  end

  def my_dup(b = @grid)
    result = []
    b.each do |el|
      if el.is_a?(Array)
        result << my_dup(el) # el is row
      else
        result << el # el is piece
      end
    end

    result
  end

  # private

  def set_up_board
    grid = Array.new(8) { Array.new(8) }
    grid.map.with_index do |line, line_idx|
      case line_idx
      when 0, 7
        create_first_line(line_idx)
      when 1, 6
        create_pawns_line(line_idx)
      else
        create_null_line
      end
    end
  end

  def create_null_line
    Array.new(8, NullPiece.instance)
  end

  def create_pawns_line(line)
    color = line == 1 ? :black : :white
    result = []
    8.times { |i| result << Pawn.new([line, i], self, color) }

    result
  end

  def create_first_line(line)
    color = line == 0 ? :black : :white

    result = []

    result << Rook.new([line, 0], self, color)
    result << Knight.new([line, 1], self, color)
    result << Bishop.new([line, 2], self, color)

    if color == :black
      result << Queen.new([line, 3], self, color)
      result << King.new([line, 4], self, color)
    else
      result << Queen.new([line, 3], self, color)
      result << King.new([line, 4], self, color)
    end

    result << Bishop.new([line, 5], self, color)
    result << Knight.new([line, 6], self, color)
    result << Rook.new([line, 7], self, color)

    result
  end

  def iteration(color, &prc)
    (0...8).each do |row|
      (0...8).each do |col|
        el = self[[row, col]]
        next if el.is_a?(NullPiece)
        prc.call(el) if el.color == color
      end
    end
  end

  def find_king(color)
    iteration(color) do |el|
      return el.pos if el.is_a?(King)
    end
  end

  def in_check?(color)
    king_pos = find_king(color)
    enemy_color = color == :black ? :white : :black
    iteration(enemy_color) { |el| return true if el.moves.include?(king_pos)}

    false
  end

  def checkmate?(color)
    if in_check?(color)
      iteration(color) { |el| return false unless el.valid_moves.empty? }
      return true
    end

    false
  end

end
