require "colorize"
require_relative "style.rb"
require_relative "printing.rb"

# Create a new Code object for each turn
class Code
  include Printing
  
  attr_reader :sequence
  def initialize(sequence)
    @sequence = sequence
  end

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
end

class Pegs
  attr_reader :correct, :semi_correct
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
end


# TEST CODE
# my_code = Code.new("1234")
# my_code.print_sequence

# results = Pegs.new(1, 2)
# results.print_feedback