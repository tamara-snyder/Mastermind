# require_relative 'players.rb'
require './game_pieces'
require './player'
require './computer'
require './knuth.rb'

class Game
  attr_reader :mode, :player, :computer, :comp_solver
  attr_accessor :rounds
  def initialize(mode)
    @mode = mode
    @player = Player.new(@mode)
    @comp_solver = ComputerSolver.new
    @rounds = 1
    @guesser = @mode == "1" ? @comp_solver : @player
    @code = @player.code
    @master = ""
  end

  def play
    set_up
    # if @mode == "1"
      # Just enter one code as the master code
      # mode_one
    # else # @mode == "2"
      # Keep guessing until game over
    mode_two
    # end

    print_results(@guesser)
    new_game
  end

  def computer_play
    guesses = 1
    answer = @code # AKA the master code
    @comp_solver.possible_scores
    @comp_solver.possible_answers

    # while @guesses <= 12
    until game_over?
      guess = @comp_solver.make_guess(guesses)
      code = Code.new(guess)
      code.print_sequence
      if @comp_solver.all_answers.include?(code.sequence)
        guesses += 1
        @comp_solver.score = feedback(answer.split("").map(&:to_i), code)
      end
    end
  end

  # def self.get_mode
  #   input = ""
  #   until input == "1" || input == "2"
  #     puts "Enter '1' to be the code maker or '2' to be the code breaker:"
  #     input = gets.chomp
  #   end
  #   # Return as integer to be used as argument to new player object
  #   input
  # end

  def mode_one
    @master = @player.set_master
    computer_play
  end

  def mode_two
    comp = Computer.new(@master)
    @master = comp.create_code
    guess
  end

  # def set_up
  #   Game.print_instructions
  # end

  def guess
    until game_over?
      p @master
      # print_turn
      @code = guess_code
      print_code(@code)
      feedback(@master, @code)
      @rounds += 1
    end
  end

  def self.print_instructions
    puts "Welcome to Mastermind!"
    puts "The game is simple. There are are six different colors you can use: "
    Code.new("123456").print_sequence
    puts "You can be the code maker or the code breaker."
    puts "The code maker chooses a combination of four numbers 1-6."
    puts "The code breaker must guess the secret code in 12 tries or less!\n"
  end

  def self.get_role
    input = ""
    until input == "1" || input == "2"
      puts "Enter '1' to be the code maker or '2' to be the code breaker:"
      input = gets.chomp
    end
    # Return as integer to be used as argument to new player object
    input.to_i
  end

  def print_turn
    puts "\nTurn ##{@rounds}:"
  end

  def guess_code
    Code.new(@player.guess)
  end

  # code = code object
  def print_code(code)
    code.print_sequence
  end

  def winner?
    guess = @guesser.code.split("").map(&:to_i)
    guess.eql?(@master)
  end

  def game_over?
    @rounds > 12 || winner?
  end

  # Returns [correct, semi_correct]
  def compare(master, guess)
    master = master.clone
    guess = guess.clone
    # player_code = @player.code.clone
    # comp_code = @computer.code.clone

    correct = matches(master, guess)
    semi_correct = semi_matches(master, guess)

    # Initialize Keys object for this guess and print feedback
    [correct, semi_correct]
  end

  # Returns number of exact matches
  def matches(master, guess)
    correct = 0
    guess = guess.sequence.split("").map(&:to_i)

    master.each_with_index do |item, index|
      next unless item == guess[index]
      correct += 1
      master[index] = "correct"
      guess[index] = "correct"
    end
    correct
  end

  # Returns number of partial matches
  def semi_matches(master, guess)
    semi_correct = 0
    guess = guess.sequence.split("").map(&:to_i)

    guess.each_index do |index|
      next unless guess[index] != "correct" && master.include?(guess[index])
      semi_correct += 1
      cross_off = master.find_index(guess[index])
      master[cross_off] = "semi_correct"
      guess[index] = "semi_correct"
    end
    semi_correct
  end


  def feedback(guess, answer)
    scores = compare(guess, answer)
    p scores
    feedback = Keys.new([scores[0], scores[1]])
    p feedback
    feedback.print_feedback
    puts "#{feedback.correct} pieces in the correct place and #{feedback.semi_correct} other pieces that exist somewhere in the code."
    feedback
  end

  def print_results(guesser)
    if winner?
      puts "#{guesser} cracked the code!"
    else
      puts "#{guesser} didn't guess the code in time."
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
  Game.print_instructions
  # game = Game.new(Player.get_role)
  game = Game.new
  game.play
end

play_game