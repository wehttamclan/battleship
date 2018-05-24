require './lib/board'

class Validator
  attr_reader :head, :tail

  def initialize(head, tail=nil, length=nil)
    @head = head.upcase
    @tail = tail.upcase
    @orientation = orientation
    @length = length
    @type = type
  end

  def is_valid?
    if on_board?
      return boat_validator if @length == 2
      return destroyer_validator   if @length == 3
    else
      false
    end
  end

  def type
    return :Boat if @length == 2
    return :Destroyer   if @length == 3
  end

  def orientation
    return :Horizontal if @head[0] == @tail[0]
    return :Vertical   if @head[1] == @tail[1]
  end

  def on_board?
    spaces = Board.new.spaces
    spaces.include?(head) && spaces.include?(tail)
  end

  def boat_validator
    if orientation == :Horizontal
      [['1','2'], ['2','3'], ['3','4']].include?([head[1], tail[1]].sort)
    elsif orientation == :Vertical
      [['A','B'], ['B','C'], ['C','D']].include?([head[0], tail[0]].sort)
    end
  end

  def destroyer_validator
    if orientation == :Horizontal
      [['1','3'], ['2','4']].include?([head[1], tail[1]].sort)
    elsif orientation == :Vertical
      [['A','C'], ['B','D']].include?([head[0], tail[0]].sort)
    end
  end
end
