class Computer
  attr_accessor :master
  def initialize(master)
    # @role = role
    @master = master
  end

  def create_code
    @master = Array.new(4){|i| i = rand(1..6)}
  end

  def guess
    Array.new(4){|i| i = rand(1..6)}
  end
end

# TESTING CODE GENERATOR
# comp = Computer.new(1)
# p comp.code

# comp.set_code