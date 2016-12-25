require_relative './piece'

class Board
  attr_accessor :grid

  def initialize(set_up = true)
    @grid = Array.new(8) { Array.new(8, NullPiece.instance) }
    set_up_board if set_up
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

  def move_piece(player, start_pos, end_pos)
    if !in_bounds?(end_pos)
      raise 'You\'re out of bounds'
    elsif self[start_pos].is_a?(NullPiece)
      raise 'Start position empty'
    elsif player != self[start_pos].color
      raise 'Can\'t move enemie\'s piece'
    elsif self[start_pos].color == self[end_pos].color
      raise 'Can\'t attack same color pieces'
    elsif !self[start_pos].moves.include?(end_pos)
      raise 'Invalid move for this piece'
    elsif !self[start_pos].valid_moves.include?(end_pos)
      raise 'You can\'t move into check'
    end

    move_piece!(start_pos, end_pos)
  end

  def move_piece!(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[end_pos].pos = end_pos
    self[start_pos] = NullPiece.instance
  end

  def set_up_board
    @grid = @grid.map.with_index do |_, line_idx|
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
    result = Array.new(8)

    result.map.with_index { |_, i| Pawn.new([line, i], self, color) }
  end

  def create_first_line(line)
    color = line.zero? ? :black : :white
    result = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    result.map.with_index do |piece, idx|
      piece.new([line, idx], self, color)
    end
  end

  def iteration
    (0...8).each do |row|
      (0...8).each do |col|
        el = self[[row, col]]
        next if el.is_a?(NullPiece)
        yield el
      end
    end
  end

  def find_king(color)
    iteration do |el|
      return el.pos if el.color == color && el.is_a?(King)
    end
  end

  def in_check?(color)
    king_pos = find_king(color)
    enemy_color = color == :black ? :white : :black
    iteration do |el|
      return true if el.color == enemy_color &&
                     el.moves.include?(king_pos)
    end

    false
  end

  def checkmate?(color)
    if in_check?(color)
      iteration do |el|
        return false if el.color == color && !el.valid_moves.empty?
      end

      return true
    end

    false
  end

  def copy
    result = Board.new(false)
    iteration do |el|
      result[el.pos] = el.class.new(el.pos, result, el.color)
    end

    result
  end

end
