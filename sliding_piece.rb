module SlidingPiece

  def moves(curr_pos, dir)
   row, col = curr_pos
   dir.map do |move|
     [@pos[0] + move[0], @pos[1] + move[1]]
   end.select { |move| @board.in_bounds?(move) && @board[move].is_a?(NullPiece) }
 end

  def move_dirs(board)
    # moves.select { |move| board[move].is_a?(NullPiece) }
  end

end
