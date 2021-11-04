class Player
  attr_accessor :code
  attr_reader :role, :name
  def initialize(role)
    @name = "You"
    @role = role
    @code = ""
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
      puts "Enter a 4-digit code using only numbers 1-6: "
      code = get_code
    end
    # Turn string into arr of integers
    @code = code #.split("").map(&:to_i)
    # code
  end

  def self.get_role
    input = ""
    until input == "1" || input == "2"
      puts "Enter '1' to be the code maker or '2' to be the code breaker:"
      input = gets.chomp
    end
    # Return as integer to be used as argument to new player object
    input
  end

  def set_master
    puts "Enter your master code:"
    until valid_code?(@code)
      puts "Enter a 4-digit code using only numbers 1-6: "
      @code = get_code
    end
    @code
  end
end