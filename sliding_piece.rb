module SlidingPiece
  def moves
    result = []
    move_dirs.each do |dir|
      pos = add_pos(@pos, dir)
      result += rec_method(pos, dir)
    end

    result
  end

  def rec_method(curr_pos, dir)
    return [] unless valid_move(curr_pos)
    return [curr_pos] unless @board[curr_pos].is_a?(NullPiece) ||
                             @board[curr_pos].color == @color

    next_pos = add_pos(curr_pos, dir)

    [curr_pos] + rec_method(next_pos, dir)
  end

  def valid_move(pos)
    @board.in_bounds?(pos) && @board[pos].color != @color
  end

  def add_pos(prev, dir)
    [prev[0] + dir[0], prev[1] + dir[1]]
  end

  def horizontal
    [
      [-1, 0],
      [0, -1],
      [0, 1],
      [1, 0]
    ]
  end

  def diagonals
    [
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1]
    ]
  end
end
