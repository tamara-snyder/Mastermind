class Computer
  attr_reader :code
  def initialize
    # @role = role
    @code = Array.new(4){|i| i = rand(1..6)}
  end

  # def create_code
  #   @code = Array.new(4){|i| i = rand(1..6)}
  # end
end

# TESTING CODE GENERATOR
# comp = Computer.new(1)
# p comp.code

# comp.set_code