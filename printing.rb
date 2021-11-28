require_relative "display.rb"

module Printing
  def print_instructions
    puts "Welcome to Mastermind!"
    puts "The game is simple. There are are six different colors you can use: "
    Code.new("123456").print_code
    puts "You can be the code maker or the code breaker."
    puts "The code maker chooses a combination of four numbers 1-6."
    puts "The code breaker must guess the secret code in 12 tries or less!\n"
  end

  # Take a string of numbers and split them, colorize them, and print in a row
  def print_code
    codes = @sequence.split("")
    decorated = ""
    codes.each {|code| decorated += decorate(code) + " "}
    puts decorated
  end

  # Print feedback based on @correct and @semi_correct variables in this instance of Pegs
  def print_feedback
    feedback = "Clues: "

    if @correct > 0
      @correct.times {feedback += decorate("correct")}
    end

    if @semi_correct > 0
      @semi_correct.times {feedback += decorate("semi-correct")}
    end

    puts feedback
  end

  def print_turn
    puts "\nTurn ##{@rounds}:"
  end

  # def print_code(code)
  #   code.print_sequence
  # end

  def print_results(guesser)
    if winner?
      puts "#{guesser} cracked the code!"
    else
      puts "#{guesser} didn't guess the code in time."
    end
  end
end