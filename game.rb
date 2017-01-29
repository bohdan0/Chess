require_relative 'display'
require_relative 'player'
require_relative 'board'

class Game

  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
    @current_player = @player1
    @display = Display.new(@board, @current_player)
  end

  def play
    until @board.checkmate?(@current_player.color)
      begin
        from, to = user_input
        @board.move_piece(@current_player.color, from, to)
        toggle_players
      rescue StandardError => e
        @display.notifications = e.message
        retry
      end
    end

    puts "Checkmate! #{ @current_player.color } lost!"
  end

  def toggle_players
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def user_input
    from, to = nil, nil
    @display.current_player = @current_player

    until from && to
      if from
        to = @display.render(from)
      else
        from = @display.render
      end
      @display.notifications = ''
    end

    [from, to]
  end
end

if __FILE__ == $PROGRAM_NAME
  player1 = Player.new(:white)
  player2 = Player.new(:black)
  game = Game.new(player1, player2)

  game.play
end
