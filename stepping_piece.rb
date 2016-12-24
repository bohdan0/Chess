module SteppingPiece
  def moves
    result = []
    move_dirs.each do |dir|
      position = add_pos(@pos, dir)
      result << position if valid_move?(position)
    end

    result
  end

  def valid_move?(move)
    @board.in_bounds?(move) &&
    (@board[move].is_a?(NullPiece) || @board[move].color != @color)
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

  def knight
    [
      [-2, 1],
      [-1, 2],
      [1, 2],
      [2, 1],
      [2, -1],
      [1, -2],
      [-1, -2],
      [-2, -1]
    ]
  end
end
