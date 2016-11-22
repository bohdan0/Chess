module SlidingPiece

  def moves
    result = []
    move_dirs.each do |dir|
      pos = add_pos(@pos, dir)
      result.concat(rec_method(pos, dir))
    end

    result
  end

  def rec_method(pos, dir)
    next_pos = add_pos(pos, dir)
    return [] unless valid_move?(next_pos)
    [pos] + rec_method(next_pos, dir)
  end

  def add_pos(prev, dir)
    [prev[0] + dir[0], prev[1] + dir[1]]
  end

  def valid_move?(move)
    @board.in_bounds?(move) &&
    (@board[move].is_a?(NullPiece) || @board[move].color != @color)
  end

  def horizontal
    [
      [- 1, 0],
      [0, - 1],
      [0, 1],
      [1, 0]
    ]
  end

  def diagonals
    [
      [- 1, - 1],
      [- 1, 1],
      [1, - 1],
      [1, 1]
    ]
  end
end
