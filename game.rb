require_relative 'board'
require_relative 'display'
# require_relative 'piece'

class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @current_player = :white
  end

  def play
    until @board.checkmate?(@current_player)
      begin
        from, to = get_input
        @board.move_piece(from, to)

        toggle_players
      rescue StandardError => e
        @display.notifications = e.message
        retry
      end
    end
  end

  def toggle_players
    @current_player = (@current_player == :white) ? :black : :white
  end

  def get_input
    from, to = nil, nil

    until from && to
      if from
        to = @display.render
      else
        from = @display.render
      end
      @display.notifications = ''
    end

    [from, to]
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
