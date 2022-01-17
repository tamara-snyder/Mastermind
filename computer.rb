class Computer
  attr_reader :code
  def initialize
    @code = Array.new(4){|i| i = rand(1..6)}
  end
end