class Ship
  attr_reader :length, :type, :sunk, :health

  def initialize(length)
    @length = length
    @health = length
    @type = type
    @sunk = false
  end

  def hit
    @health -= 1
    sunk?
  end

  def sunk?
    @sunk = true if @health == 0
    @sunk
  end

  def type
    return 'Boat' if @length == 2
    return 'Destroyer' if @length == 3
  end
end
