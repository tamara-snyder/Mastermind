require './style'
require './game_pieces'
require './player'
require './computer'

class Game
  attr_reader :player, :computer
  attr_accessor :rounds
  def initialize
    @player = Player.new
    @computer = Computer.new
    @rounds = 1
  end

  def play
    set_up
    guess
    print_results
    new_game
  end

  def set_up
    Game.print_instructions
  end

  def guess
    until game_over?
      print_turn
      print_code
      feedback
      @rounds += 1
    end
  end

  def self.print_instructions
    puts "  Mastermind  ".white.bold.on_purple
    puts "\nThe computer will choose a sequence of four colors. 
      \nThere are are six different colors you can use to guess the code:\n "
    Code.new("123456").print_sequence
    puts "\n A red star #{"*".red.bold} means some color in your code was the #{"right color".bold} and in the #{"right place".bold}."
    puts "\n A red star #{"*".white.bold} means some color in your code was the #{"right color".bold}, but in the #{"wrong place".bold}."
    puts "\nGuess the secret code in 12 tries or less!"
  end

  def print_turn
    puts "\nRound #{@rounds}/12:".bold
  end

  def print_code
    Code.new(@player.guess).print_sequence
  end

  def winner?
    @player.code.eql?(@computer.code)
  end

  def game_over?
    @rounds > 12 || winner?
  end

  def compare
    player_code = @player.code.clone
    comp_code = @computer.code.clone

    correct = full_matches(comp_code, player_code)
    semi_correct = partial_matches(comp_code, player_code)

    # Initialize Keys object for this guess and print feedback
    [correct, semi_correct]
  end

  def full_matches(comp_code, player_code)
    correct = 0

    comp_code.each_with_index do |item, index|
      next unless item == player_code[index]
      correct += 1
      comp_code[index] = "correct"
      player_code[index] = "correct"
    end
    correct
  end

  def partial_matches(comp_code, player_code)
    semi_correct = 0

    player_code.each_index do |index|
      next unless player_code[index] != "correct" && comp_code.include?(player_code[index])
      semi_correct += 1
      cross_off = comp_code.find_index(player_code[index])
      comp_code[cross_off] = "semi_correct"
      player_code[index] = "semi_correct"
    end
    semi_correct
  end

  def feedback
    feedback = Keys.new(compare)
    feedback.print_feedback
    puts "You had #{feedback.correct} pieces in the correct place and #{feedback.semi_correct} other pieces that exist somewhere in the code."
  end

  def print_results
    if winner?
      puts "You cracked the code!"
    else
      puts "You didn't guess the code this time. The code was '#{@computer.code.join}'"
    end
  end

  def new_game
    puts "Play again? Press 'y' for yes or 'n' for no.".bold
    input = gets.chomp.downcase
    if input == 'y'
      play_game
    else
      puts "Thanks for playing!".bold
    end
  end

end


def play_game
  Game.new.play
end

play_game