require_relative "display.rb"
require_relative "player.rb"
require_relative "computer.rb"
require_relative "printing.rb"

class Game
  include Printing

  attr_reader :player, :computer
  attr_accessor :round_number, :mode, :guesser, :setter
  def initialize()
    @mode
    @player = Player.new
    @computer = Computer.new
    @round_number = 1
    @guesser
    @setter
    # @code = ""
    # @guesser = @mode == "1" ? @comp_solver : @player
    # @code = @player.code
    # @secret_code = ""
  end

  def play
    puts @guesser
    self.print_instructions

    role = @player.choose_role
    
    if role == 'codesetter'
      @guesser = @computer
      @setter = @player
    else
      @guesser = @player
      @setter = @computer
    end

    @setter.set_secret_code
    until game_over?
      take_turn
    end

    # print_results(@guesser)
    new_game
  end

  # def play_codesetter_mode
  #   guesses = 1
  #   answer = @code # AKA the secret_code code
  #   @comp_solver.possible_scores
  #   @comp_solver.possible_answers

  #   # while @guesses <= 12
  #   until game_over?
  #     guess = @comp_solver.make_guess(guesses)
  #     code = Code.new(guess)
  #     code.print_sequence
  #     if @comp_solver.all_answers.include?(code.sequence)
  #       guesses += 1
  #       @comp_solver.score = feedback(answer.split("").map(&:to_i), code)
  #     end
  #   end
  # end

  # def self.get_mode
  #   input = ""
  #   until input == "1" || input == "2"
  #     puts "Enter '1' to be the code maker or '2' to be the code breaker:"
  #     input = gets.chomp
  #   end
  #   # Return as integer to be used as argument to new player object
  #   input
  # end

  def take_turn
    guess = @guesser.guess
    give_feedback(guess, @setter.secret_code)
    print_board
  end

  # def guess
  #   until game_over?
  #     p @secret_code
  #     # print_turn
  #     @code = guess_code
  #     print_code(@code)
  #     feedback(@secret_code, @code)
  #     @round_number += 1
  #   end
  # end

  # def guess_code
  #   Code.new(@player.guess)
  # end

  def game_over?
    @round_number > 12 || winner?
  end

  def winner?
    guess = @guesser.current_guess#.split("").map(&:to_i)
    guess.eql?(@setter.secret_code)
  end

  def give_feedback(guess, answer)
    scores = compare(guess, answer)
    p scores
    feedback = Pegs.new([scores[0], scores[1]])
    p feedback
    feedback.print_feedback
    puts "#{feedback.correct} pieces in the correct place and #{feedback.semi_correct} other pieces that exist somewhere in the code."
    feedback
  end

  def compare(guess, secret_code)
    guess # = guess.clone
    secret_code # = secret_code.clone
    # player_code = @player.code.clone
    # comp_code = @computer.code.clone

    correct = calculate_exact_matches(guess, secret_code)
    partially_correct = calculate_partial_matches(guess, secret_code)

    # Initialize Pegs object for this guess and print feedback
    [correct, partially_correct]
  end

  def calculate_exact_matches(guess, secret_code)
    correct = 0
    guess = guess.split("").map(&:to_i)
    secret_code = secret_code.split("").map(&:to_i)

    secret_code.each_with_index do |item, index|
      next unless item == guess[index]
      correct += 1
      secret_code[index] = "correct"
      guess[index] = "correct"
    end
    correct
  end

  def calculate_partial_matches(guess, secret_code)
    semi_correct = 0
    guess = guess.split("").map(&:to_i)

    guess.each do |index|
      next unless guess[index] != "correct" && secret_code.include?(guess[index])
      semi_correct += 1
      cross_off = secret_code.find_index(guess[index])
      secret_code[cross_off] = "semi_correct"
      guess[index] = "semi_correct"
    end
    semi_correct
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