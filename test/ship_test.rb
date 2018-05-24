require './test/test_helper'
require './lib/ship'

class ShipTest < Minitest::Test
  def setup
    @boat = Ship.new(2)
    @destroyer = Ship.new(3)
  end

  def test_initial_health_equals_length
    assert_equal @boat.health, @boat.length
  end

  def test_ship_can_take_a_hit_and_health_decreases
    assert_equal 2, @boat.health
    @boat.hit
    assert_equal 1, @boat.health
  end

  def test_can_sink
    refute @destroyer.sunk?
    @destroyer.length.times do |get_hit|
      @destroyer.hit
    end
    assert_equal 0, @destroyer.health
    assert @destroyer.sunk?
  end

  def test_ship_knows_what_type_it_is
    assert_equal "Destroyer", @destroyer.type
    assert_equal "Boat", @boat.type
  end
end
