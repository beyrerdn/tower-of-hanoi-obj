require 'pry-byebug'

class Game
  
  def reset
    @peg_1 = [4, 3, 2, 1]
    @peg_2 = []
    @peg_3 = []
    @passes = 0
  end
  
  def start_game
    #Greeting
    puts "The object of Tower of Hanoi is to move discs one at a time to achieve peg_3 = [4, 3, 2, 1] without stacking a larger disc on top of a smaller disc. Good luck!"
    reset
    print_board
    what_peg_to_move_from?
  end
  
  def print_board
    puts "peg_1 = #{@peg_1}"
    puts "peg_2 = #{@peg_2}"
    puts "peg_3 = #{@peg_3}"
  end
  
  def get_peg(peg_number)
    instance_variable_get("@peg_#{peg_number}")
  end
  
  def get_active_peg
    get_peg(@active_peg)
  end
  
  def get_destination_peg
    get_peg(@destination_peg)
  end

  def what_peg_to_move_from?
    @active_peg = 0
    
    puts "From what peg (1, 2, or 3) would you like to move a disc?"
    response = gets.chomp
    
    if /[1-3]/.match(response) == nil
     puts "Doh! You provided #{response}... 1, 2, or 3 are the only valid responses."
     print_board
     return what_peg_to_move_from?
    else
      @active_peg = response.to_i
    end
    where_to_move_disc?
  end
  
  def where_to_move_disc?
    @destination_peg = 0
    
    puts "To what peg (1, 2, 3) will you move disc #{(get_active_peg).last}?"
    response = gets.chomp
    
    if /[1-3]/.match(response) == nil
      puts "Doh! You provided #{response}... 1, 2, or 3 are the only valid responses."
      print_board
      return where_to_move_disc?
    else
      @destination_peg = response.to_i
    end
    peg_move
  end
  
  def peg_move
    
    if get_peg(@active_peg) == []
      puts "There are no discs on peg #{@active_peg}. Try again!"
    elsif (get_destination_peg != []) and (get_active_peg.last > get_destination_peg.last)
      puts "You're trying to move a #{get_active_peg.last} disc onto a #{get_destination_peg.last} disc. You cannot move a larger disc onto a smaller disc. Try again!"
      print_board
      what_peg_to_move_from?
    else
      get_destination_peg << get_active_peg.pop
    end
    
    count
    win?
    print_board
    what_peg_to_move_from?
    
  end 
  
  def count
    @passes += 1
  end
  
  def win?
    if @peg_3 == [4, 3, 2, 1]
      puts "Congratulations!!! You won with #{@passes} moves! The minimum possible is 15."
      play_again?
    end
  end
  
  def play_again?
    puts "Would you like to play again?"
    if ['Yes','yes','y'].include?(gets.chomp)
      self.start_game
    else
      exit
    end
  end
  
end

game = Game.new
game.start_game

  