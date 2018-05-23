class Board
  attr_reader :rows, :cols

  def initialize
    @rows = ['A','B','C','D']
    @cols = ['1','2','3','4']
  end

  def spaces
    spaces = @rows.product(@cols)
    spaces = spaces.map { |space| space.join }
  end

  def blank_board
    spaces.product([' ']).to_h
  end
end

# board = Board.new
# p board.blank_board
['A1', 'A2']
