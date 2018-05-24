require './test/test_helper'
require './lib/battleship'
require './lib/ship'
require './lib/board'

class BattleshipTest < Minitest::Test
  def setup
    @validator = Validator.new(head, tail, length)
    @board = Board.new
    @patrol_boat = Ship.new(2)
    @destroyer = Ship.new(3)
  end
end
