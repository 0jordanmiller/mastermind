# frozen_string_literal: true

# class MakerCode
#   attr_accessor :red, :white, :color

#   def initialize(color)
#     @red = false
#     @white = false
#     @color = color
#   end
# end

def colors
  %w[R G B Y W P]
end

def validate_regex(input)
  false_regex = /\A[RGBYWP][RGBYWP][RGBYWP][RGBYWP]\z/.match?(input)
  unless false_regex
    while false_regex == false
      puts 'Please input a valid combination of five colors e.g. RGBW: '
      input = gets.chomp.upcase
      false_regex = /\A[RGBYWP][RGBYWP][RGBYWP][RGBYWP]\z/.match?(input)
    end
  end
  input
end

def computer_code(colors)
  code = 4.times.map { colors[rand(6)] }
  code.join
end

def breaker_guess
  input = gets.chomp.upcase
  input = validate_regex(input)
end

def feedback(code_maker, code_breaker)

  code_breaker_accounted = [false, false, false, false]
  red = 0
  white = 0

  code_maker.chars.each.with_index do |maker_letter, i|
    code_breaker.chars.each.with_index do |breaker_letter, j|
      p j

      if maker_letter == breaker_letter && i == j
        red += 1
        code_breaker_accounted[j] = true
        break
      elsif maker_letter == breaker_letter && code_breaker_accounted[j] == false
        white += 1
        code_breaker_accounted[j] = true

        break
      end
    end
    # p code_breaker_accounted
  end
  p "end of feedback: red: #{red} white: #{white}"
end


def check_winner(code_maker, code_breaker)
  if code_maker == code_breaker
    true
  else
    feedback(code_maker, code_breaker)
  end
end

def start_game
  winner = false
  puts 'Try and break the code. Input four colors, Red, Green, Blue, Yellow, White, Purple. Sample input: RGBWY. '
  guesses = []
  # computer_code = computer_code(colors)
  # computer_code.chars.each {|code| print code}
  print "WWRY"
  turn = 0
  while turn < 10 && winner == false
    print "\nPlease guess: "
    breaker_guess = breaker_guess()
    guesses.push(breaker_guess)
    guess = check_winner("WWRY", breaker_guess)

    turn += 1
  end
  print 'Winner!' if winner == true
end

start_game
