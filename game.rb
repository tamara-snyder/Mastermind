# require_relative 'players.rb'
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
    puts "Welcome to Mastermind"
    puts "The game is simple. There are are six different colors you can use: "
    Code.new("123456").print_sequence
    puts "You can be the code maker or the code breaker."
    puts "The code maker chooses a combination of four numbers 1-6."
    puts "The code breaker must guess the secret code in 12 tries or less!"
  end

  def print_turn
    puts "\nRound #{@rounds}/12:"
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

    correct = matches(comp_code, player_code)
    semi_correct = semi_matches(comp_code, player_code)

    # Initialize Keys object for this guess and print feedback
    [correct, semi_correct]
  end

  def matches(comp_code, player_code)
    correct = 0

    comp_code.each_with_index do |item, index|
      next unless item == player_code[index]
      correct += 1
      comp_code[index] = "correct"
      player_code[index] = "correct"
    end
    correct
  end

  def semi_matches(comp_code, player_code)
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
      puts "You didn't guess the code this time."
    end
  end

  def new_game
    puts "Play again? Press 'y' for yes or 'n' for no."
    input = gets.chomp.downcase
    if input == 'y'
      play_game
    else
      puts "Thanks for playing!"
    end
  end

end


def play_game
  Game.new.play
end

play_game