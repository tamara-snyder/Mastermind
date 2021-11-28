require_relative "display.rb"

class Computer
  attr_accessor :secret_code, :current_guess
  def initialize
    @secret_code = ""
    @current_guess = ""
  end

  def set_secret_code
    @secret_code = guess
  end

  def guess
    @current_guess = Array.new(4){|i| i = rand(1..6)}.join("")
  end
end

# TESTING CODE GENERATOR
# comp = Computer.new(1)
# p comp.code

# comp.set_code