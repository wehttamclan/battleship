class Printer
  def place_boat
    puts "I have laid out my ships on the grid.\n"\
    "You now need to lay out your two ships.\n"\
    "The first is two units long and the second is three units long.\n"\
    "The grid has A1 at the top left and D4 at the bottom right.\n\n"\
    "Enter the squares for the two-unit Boat:"\
  end

  def place_destroyer
    puts "\nEnter the squares for the three-unit Destroyer:"
  end

  def invalid
    puts 'That is invalid!'
  end

  def welcome
    puts 'Welcome to BATTLESHIP'
  end

  def select
    puts 'Would you like to (p)lay, read the (i)nstructions, or (q)uit?'
  end

  def instructions
    puts "instructions\n"
  end

  def bye
    puts 'OK, bye!'
  end

  def enter_shot
    puts "\nEnter your shot coordinates:"
  end

  def duplicate_shot
    puts "\nYou've already shot at this location. Please shoot again."
  end

  def off_the_board
    puts 'Please select a valid space on the board.'
  end

  def hit
    puts "\nHit!"
  end

  def miss
    puts "\nYou missed!"
  end

  def get_hit
    puts "You've been hit!"
  end

  def enemy_miss
    puts "You've been shot at, but your enemy has missed!"
  end
end
