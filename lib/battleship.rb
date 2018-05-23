require './lib/ship'
require './lib/board'
require './lib/validator'

class Battleship
  attr_reader :board

  def initialize
    @board = Board.new
    @patrol_boat = Ship.new(2)
    @destroyer = Ship.new(3)
  end

  def validator(head, tail, length)
    Validator.new(head, tail, length)
  end

  def start_game
    puts 'Welcome to BATTLESHIP'
    while main_menu
      main_menu
    end
  end

  def main_menu
    puts 'Would you like to (p)lay, read the (i)nstructions, or (q)uit?'\
         '>'
    selection == gets.chomp
    if    selection == 'p' || selection == 'play'
      play
    elsif selection == 'i' || selection == 'instructions'
      puts 'instructions'
    elsif selection == 'q' || selection == 'quit'
      return false
    end
  end

  def play
    # put these in the runner?
    comp_board = board.blank_board
    comp_patrol_boat = @patrol_boat
    comp_destroyer   = @destroyer
    comp_patrol_boat_location = generate_computer_ship_locations[:patrol_boat]
    comp_destroyer_location   = generate_computer_ship_locations[:destroyer]
    player_board = board.blank_board
    player_patrol_boat = @patrol_boat
    player_destroyer   = @destroyer
    player_patrol_boat_location = place_patrol_boat
    player_destroyer_location
    # put these in the runner?

    print_board(comp_board)
    until comp_patrol_boat.health + comp_destroyer.health == 0
      print "Enter your shot coordinates. \n>"
      shot = gets.chomp.strip.upcase
      # player shot method
      if comp_board.keys.include?(shot)
        if comp_patrol_boat_location.include?(shot)
          comp_patrol_boat.hit
          comp_board[shot] = 'X'
          puts 'Hit!'
        elsif comp_destroyer_location.include?(shot)
          comp_destroyer.hit
          comp_board[shot] = 'X'
          puts 'Hit!'
        else
          comp_board[shot] = 'O'
        end
        print_board(comp_board)
      else
        puts 'You missed the whole board!'
      end
      # player shot method
    end
  end

  def generate_computer_ship_locations
    patrol_boat_location = computer_place_patrol_boat
    destroyer_location = computer_place_destroyer
    while patrol_boat_location.any? {|space| destroyer_location.include?(space)}
      destroyer_location = computer_place_destroyer
    end
    locations = {
      patrol_boat: patrol_boat_location,
      destroyer: destroyer_location
    }
  end

  def print_board(map)
    puts "===========\n"\
    ". 1 2 3 4 |\n"\
    "A #{map["A1"]} #{map["A2"]} #{map["A3"]} #{map["A4"]} |\n"\
    "B #{map["B1"]} #{map["B2"]} #{map["B3"]} #{map["B4"]} |\n"\
    "C #{map["C1"]} #{map["C2"]} #{map["C3"]} #{map["C4"]} |\n"\
    "D #{map["D1"]} #{map["D2"]} #{map["D3"]} #{map["D4"]} |\n"\
    "===========\n"
    map
  end

  def computer_place_patrol_boat
    coordinate_1 = (board.rows + board.cols).sample
    if board.rows.include?(coordinate_1)
      row_placement = [['1','2'], ['2','3'], ['3','4']].sample
      coordinates = row_placement.map { |col| coordinate_1 + col }
    elsif board.cols.include?(coordinate_1)
      col_placement = [['A','B'], ['B','C'], ['C','D']].sample
      coordinates = col_placement.map { |col|  col + coordinate_1 }
    end
  end

  def computer_place_destroyer
    coordinate_1 = (board.rows + board.cols).sample
    if board.rows.include?(coordinate_1)
      row_placement = [['1','2','3'], ['2','3','4']].sample
      coordinates = row_placement.map { |col| coordinate_1 + col }
    elsif board.cols.include?(coordinate_1)
      col_placement = [['A','B','C'], ['B','C','D']].sample
      coordinates = col_placement.map { |col|  col + coordinate_1 }
    end
  end

  def place_patrol_boat
    puts 'Enter the positions for your two-unit Patrol Boat:'
    positions = gets.chomp.upcase
    head, tail = positions.split[0], positions.split[1]
    if validator(head, tail, 2).is_valid?
      # orientation = validator(head, tail, 2).orientation
      return [head, tail]
    else
      p "That's invalid."
    end
  end

  def place_destroyer
    p 'Enter the positions for your three-unit Destroyer:'
    positions = gets.chomp.upcase
    head, tail = positions.split[0], positions.split[1]
    if validator(head, tail, 3).is_valid?
      orientation = validator(head, tail, 3).orientation
      if orientation == :Horizontal
        if ['1', '3'] == [head[1], tail[1]].sort
          p ['1','2','3'].map { |col| head[0] += col }
        elsif ['2', '4'] == [head[1], tail[1]].sort
          p ['2','3','4'].map { |col| head[0] += col }
        end
      elsif orientation == :Vertical
        if ['A', 'C'] == [head[0], tail[0]].sort
          p ['A','B','C'].map { |row| row += head[1] }
        elsif ['B', 'D'] == [head[0], tail[0]].sort
          p ['B','C','D'].map { |col| row += head[1] }
        end
      end
    else
      puts "That is invalid."
    end
  end
end








b = Battleship.new
b.play
