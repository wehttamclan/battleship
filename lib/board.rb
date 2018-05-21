class Board
  attr_reader :spaces, :rows, :cols

  def initialize
    @rows = ['A','B','C','D']
    @cols = ['1','2','3','4']
    @spaces = @rows.product(@cols)
  end

  def blank_board
    hash = {}
    spaces.map { |space| hash[space.join] = ' '}
    hash
  end
end

# board = Board.new
# p board.blank_board
