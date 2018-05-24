require './test/test_helper'
require './lib/board'

class BoardTest < Minitest::Test
  def test_there_are_rows_and_cols
    board = Board.new
    rows = board.rows
    cols = board.cols
    assert_equal ['A','B','C','D'], rows
    assert_equal ['1','2','3','4'], cols
  end

  def test_it_can_make_all_16_spaces_from_rows_and_cols
    board = Board.new
    spaces = ['A1', 'A2', 'A3', 'A4',
              'B1', 'B2', 'B3', 'B4',
              'C1', 'C2', 'C3', 'C4',
              'D1', 'D2', 'D3', 'D4']
    assert_equal spaces, board.spaces
  end

  def test_it_can_create_a_blank_board_in_hash_form
    board = Board.new
    blank_board = {
      'A1'=>' ', 'A2'=>' ', 'A3'=>' ', 'A4'=>' ',
      'B1'=>' ', 'B2'=>' ', 'B3'=>' ', 'B4'=>' ',
      'C1'=>' ', 'C2'=>' ', 'C3'=>' ', 'C4'=>' ',
      'D1'=>' ', 'D2'=>' ', 'D3'=>' ', 'D4'=>' '
    }
    assert_equal blank_board, board.blank_board
  end
end
