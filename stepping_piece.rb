module SteppingPiece
require 'byebug'
  def moves
    result = []
    move_dirs.each do |dir|
      # debugger
      position = add_pos(@pos, dir)
      result << position if valid_move?(position)
    end

    result
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

  def knight
    [
      [- 2, 1],
      [- 1, 2],
      [1, 2],
      [2, 1],
      [2, - 1],
      [1, - 2],
      [- 1, - 2],
      [- 2, - 1]
     ]
   end
end
