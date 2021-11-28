require_relative "display.rb"

class Player
  attr_accessor :secret_code, :current_guess
  attr_reader :name
  def initialize
    @name = "You"
    @secret_code = ""
    @current_guess = ""
  end

  def choose_role
    role = "0"
    until role == "1" || role == "2"
      puts role
      puts "Press '1' to be the code-setter or '2' to be the code-breaker:"
      role = gets.chomp
    end
    role == "1" ? "codesetter" : "codebreaker"
  end

  # Code must be 4 digits between 1 and 6
  def valid_code?(code)
    code.length == 4 && code.scan(/\D/).empty? && code.split("").all? {|char| char.to_i >= 1 && char.to_i <= 6}
  end

  def get_code
    gets.chomp
  end

  def guess
    code = ""
    until valid_code?(code)
      puts "Enter a 4-digit code using only numbers 1-6:"
      code = get_code
    end
    # Turn string into arr of integers
    @current_guess = code #.split("").map(&:to_i)
    code
  end

  def set_secret_code
    puts "Enter your secret code."
    @secret_code = guess
    # until valid_code?(code)
    #   puts "[Enter a 4-digit code using only numbers 1-6]: "
    #   @secret_code = get_code
    # end
    # @secret_code
  end
end