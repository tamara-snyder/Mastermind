require 'colorize'

# Create a new Code object for each turn
class Code
  # Colors: red, blue, yellow, green, white, and black
  attr_reader :sequence
  def initialize(sequence)
    @sequence = sequence
  end

  # Colorize peg based on its number
  def decorate(code)
    code = code
    case code
    when "1"
      " #{code} ".black.on_light_red
    when "2"
      " #{code} ".black.on_cyan
    when "3"
      " #{code} ".black.on_light_yellow
    when "4"
      " #{code} ".black.on_green
    when "5"
      " #{code} ".black.on_light_white
    when "6"
      " #{code} ".black.on_light_black
    else
      "Enter a number 1-6"
    end
  end

  # Take a string of numbers and split them, colorize them, and print in a row
  def print_sequence
    codes = @sequence.split("")
    decorated = ""
    codes.each {|code| decorated += decorate(code) + " "}
    puts decorated
  end
end

# Create a new Keys object for each turn
class Keys
  # white, red
  attr_reader :correct, :semi_correct

  # Takes an array of length 2
  def initialize(matches)
    # Both will be numbers
    @correct = matches[0]
    @semi_correct = matches[1]
  end

  # Color key pegs accordingly
  def decorate(peg_type)
    if peg_type == "correct"
      " * ".red
    else
      " * ".white
    end
  end

  # Print feedback based on @correct and @semi_correct variables in this instance of Keys
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
end


# TEST CODE
# my_code = Code.new("1234")
# my_code.print_sequence

# results = Keys.new(1, 2)
# results.print_feedback