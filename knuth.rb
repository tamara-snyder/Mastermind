require 'set'

# Uses Donald Knuth's minimax algorithm to solve the code in 5 tries or less
class CompSolver
  attr_reader :name
  attr_accessor :all_answers, :all_scores, :code, :possible_scores, :possible_answers, :score
  # Create algorithm
  def initialize
    @name = "The computer"
    # Array of string numbers 1-6
    colors = "123456".chars.map(&:to_i)
    @all_answers = colors.product(*[colors] * 3).map(&:join)
    @all_scores = Hash.new {|h, k| h[k] = {}}

    @all_answers.product(@all_answers).each do |guess, answer|
      @all_scores[guess][answer] = Keys.new([guess, answer])
    end

    @possible_scores = @all_scores.dup
    @possible_answers = @all_answers.dup

    @all_answers = @all_answers.to_set
    @code = ""
    @score = 0
  end

  # def play
  #   @guesses = 1
  #   @answer = @player.code # AKA the master code
  #   @possible_scores = @all_scores.dup
  #   @possible_answers = @all_answers.dup

  #   # while @guesses <= 12
  #   until game_over?
  #     @guess = make_guess
  #     code = Code.new(@guess)
  #     code.print_sequence
  #     if @all_answers.include?(@guess)
  #       @guesses += 1
  #       @score = feedback(@guess, @answer)

  #         # if Game.winner?
  #         # end
  #     end
  #   end
  # end

  def make_guess(guess_num)
    if guess_num > 1
      @possible_answers.keep_if { |answer|
        @all_scores[@guess][answer] == @score
      }
      
      guesses = @possible_scores.map do |guess, scores_by_answer|
        scores_by_answer = scores_by_answer.select {|answer, score|
          @possible_answers.include?(answer)
        }
        @possible_scores[guess] = scores_by_answer

        score_groups = scores_by_answer.values.group_by(&:itself)
        possibility_counts = score_groups.values.map(&:length)
        p possibility_counts
        worst_case_possibilities = possibility_counts.max
        impossible_guess = @possible_answers.include?(guess) ? 0 : 1
        @code = [worst_case_possibilities,impossible_guess, guess]
        p @code
      end

      # @code = guess_num.min.last
    else
      @code = "1122"
    end 
  end
end