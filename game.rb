require_relative 'board'
require_relative 'display'
# require_relative 'piece'

class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
  end

  def play
    # @display.show
    @display.render
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
