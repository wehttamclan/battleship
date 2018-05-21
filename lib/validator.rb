require './lib/board'

class Validator
  attr_reader :head, :tail

  def initialize(head, tail, length)
    @head = head
    @tail = tail
    @orientation = orientation
    @length = length
    @type = type
  end

  def is_valid?
    if on_board?
      if type == "Destroyer"
        destroyer_validator
      elsif type == "Patrol Boat"
        patrol_boat_validator
      end
    else
      false
    end

  end

  def type
    return "Patrol Boat" if @length == 2
    return "Destroyer" if @length == 3
  end

  def orientation
    return "Horizontal" if @head[0] == @tail[0]
    return "Vertical"   if @head[1] == @tail[1]
  end

  def on_board?
    spaces = Board.new.spaces
    spaces.include?([head[0], head[1]]) && spaces.include?([tail[0], tail[1]])
  end

  def destroyer_validator
    if orientation == "Horizontal"
      [['1','3'], ['2','4']].include?([head[1], tail[1]].sort)
    elsif orientation == "Vertical"
      [['A','C'], ['B','D']].include?([head[0], tail[0]].sort)
    end
  end

  def patrol_boat_validator
    if orientation == "Horizontal"
      [['1','2'], ['2','3'], ['3','4']].include?([head[1], tail[1]].sort)
    elsif orientation == "Vertical"
      [['A','B'], ['B','C'], ['C','D']].include?([head[0], tail[0]].sort)
    end
  end

  # def position_parser(position)
  #     [position[0].upcase, position[1].upcase]
  # end
end
