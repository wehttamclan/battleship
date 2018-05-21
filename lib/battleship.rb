require './lib/ship'
require './lib/board'
require './lib/validator'

class Battleship
  attr_reader :validator, :board

  def initialize
    @validator = Validator.new(head, tail, length)
    @board = Board.new
    @patrol_boat = Ship.new(2)
    @destroyer = Ship.new(3)
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
    if    selection == 'p' || selection == 'play'
      play
    elsif selection == 'i' || selection == 'instructions'
      puts 'instructions'
    elsif selection == 'q' || selection == 'quit'
      return false
    end
  end

  def play
    computer_board = generate_computer_board
    place_patrol_boat
    # place patrol boat on player board
    place_destroyer
    #place destroyer on player board
  end

  def generate_computer_board
    board.blank_board
    
  end

  def place_patrol_boat
    puts 'Enter the positions for the two-unit Patrol Boat:'
    positions = gets.chomp.upcase
    head, tail = positions.split
    valid = validator(head, tail, 2).is_valid?
  end

  def place_destroyer
    p 'Enter the positions for the three-unit Destroyer:'
    positions = gets.chomp.upcase
    head, tail = positions.split
    valid = validator(head, tail, 3).is_valid?
  end


end

b = Battleship.new
b.play
