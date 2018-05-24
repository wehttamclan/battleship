require './lib/ship'
require './lib/board'
require './lib/validator'
require './lib/printer'

class Battleship
  attr_reader :board, :comp_boat, :comp_destroyer, :player_boat,
              :player_destroyer, :comp_board#, :player_board

  def initialize
    @printer = Printer.new
    @board = Board.new
    @comp_boat = Ship.new(2)
    @comp_destroyer = Ship.new(3)
    @player_boat = Ship.new(2)
    @player_destroyer = Ship.new(3)
    @comp_board = board.blank_board
    # @player_board = player_board
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
    selection = gets.chomp.strip
    if    selection == 'p' || selection == 'play'
      play
    elsif selection == 'i' || selection == 'instructions'
      puts "instructions\n"
      main_menu
    elsif selection == 'q' || selection == 'quit'
      puts "OK, bye!"
      return false
    end
  end

  def a_sunk_fleet
    comp_health   = comp_boat.health + comp_destroyer.health
    player_health = player_boat.health + player_destroyer.health
    (comp_health == 0) || (player_health == 0)
  end

  def play
    comp_boat_location = generate_computer_ship_locations[:boat]
    comp_destroyer_location = generate_computer_ship_locations[:destroyer]
    print_board(comp_board)
    player_board = generate_player_board
    until a_sunk_fleet
      puts "\nEnter your shot coordinates. \n>"
      shot = gets.chomp.strip.upcase

      until ['B','D',' '].include?(comp_board[shot])
        if comp_board.keys.include?(shot)
          puts "\nYou've already shot at this location. Please shoot again."
          shot = gets.chomp.strip.upcase
        else
          puts "Please select a valid space on the board."
          shot = gets.chomp.strip.upcase
        end
      end

      if comp_boat_location.include?(shot)
        comp_boat.hit
        comp_board[shot] = 'X'
        puts "\nHit!"
      elsif comp_destroyer_location.include?(shot)
        comp_destroyer.hit
        comp_board[shot] = 'X'
        puts "\nHit!"
      else
        comp_board[shot] = 'O'
        puts "\nYou missed!"
      end
      print_board(comp_board)

      comp_shot = board.spaces.sample
      while ['X','O'].include?(player_board[comp_shot])
        comp_shot = board.spaces.sample
      end
      if player_board[comp_shot] == 'B'
        player_boat.hit
        player_board[comp_shot] = 'X'
        puts "You've been hit!"
      elsif player_board[comp_shot] == 'D'
        player_destroyer.hit
        player_board[comp_shot] = 'X'
        puts "You've been hit!"
      else
        player_board[comp_shot] = 'O'
        puts "You've been shot at, but your enemy has missed!"
      end
      print_board(player_board)
    end
  end

  def generate_computer_ship_locations
    boat_location = computer_place_boat
    destroyer_location = computer_place_destroyer
    while boat_location.any? {|space| destroyer_location.include?(space)}
      destroyer_location = computer_place_destroyer
    end
    locations = {
      boat: boat_location,
      destroyer: destroyer_location
    }
  end

  def print_board(map)
    puts "\n===========\n"\
    ". 1 2 3 4 |\n"\
    "A #{map["A1"]} #{map["A2"]} #{map["A3"]} #{map["A4"]} |\n"\
    "B #{map["B1"]} #{map["B2"]} #{map["B3"]} #{map["B4"]} |\n"\
    "C #{map["C1"]} #{map["C2"]} #{map["C3"]} #{map["C4"]} |\n"\
    "D #{map["D1"]} #{map["D2"]} #{map["D3"]} #{map["D4"]} |\n"\
    "===========\n\n"
    map
  end

  def computer_place_boat
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

  def generate_player_board
    boat_location = place_boat
    destroyer_location = place_destroyer
    while boat_location.any? { |space| destroyer_location.include?(space) }
      destroyer_location = place_destroyer
    end
    player_board = board.blank_board
    boat_location.map { |space| player_board[space] = 'B' }
    destroyer_location.map { |space| player_board[space] = 'D' }
    return player_board
  end

  def place_boat
    @printer.place_boat
    positions = gets.chomp.strip
    head, tail = positions.split[0], positions.split[1]
    if validator(head, tail, 2).is_valid?
      return [head, tail]
    else
      p "That's invalid."
      place_boat
    end
  end

  def place_destroyer
    @printer.place_destroyer
    positions = gets.chomp.strip
    head, tail = positions.split[0], positions.split[1]
    if validator(head, tail, 3).is_valid?
      orientation = validator(head, tail, 3).orientation
      if orientation == :Horizontal
        if ['1', '3'] == [head[1], tail[1]].sort
          return ['1','2','3'].map { |col| head[0] += col }
        elsif ['2', '4'] == [head[1], tail[1]].sort
          return ['2','3','4'].map { |col| head[0] += col }
        end
      elsif orientation == :Vertical
        if ['A', 'C'] == [head[0], tail[0]].sort
          return ['A','B','C'].map { |row| row += head[1] }
        elsif ['B', 'D'] == [head[0], tail[0]].sort
          return ['B','C','D'].map { |col| row += head[1] }
        end
      end
    else
      puts "That is invalid!"
      place_destroyer
    end
  end
end

b = Battleship.new
b.start_game
