# frozen_string_literal: true

def colors
  %w[R G B Y W P]
  # "RGBYWP"
end

def validate_regex(input)
  false_regex = /\A[RGBYWP][RGBYWP][RGBYWP][RGBYWP][RGBYWP]\z/.match?(input)
  unless false_regex
    while false_regex == false
      puts '\n Please input a valid combination of five colors e.g. RGBWY '
      input = gets.chomp
      false_regex = /\A[RGBYWP][RGBYWP][RGBYWP][RGBYWP][RGBYWP]\z/.match?(input)
    end
  end
  input
end

def computer_code(colors)
  colors = colors.shuffle
  colors.delete_at(rand(5))
  colors.join
end

def breaker_guess
  input = gets.chomp
  input = validate_regex(input)
end

def feedback(code_maker, _code_breaker)
  code_maker.each_char do |letter|
    p letter
  end
end

def check_winner(code_maker, code_breaker)
  code_maker == code_breaker
end

def start_game
  winner = false
  puts 'Try and break the code. Input five colors, Red, Green, Blue, Yellow, White, Black. Sample input: RGBWY. '
  guesses = []
  computer_code = computer_code(colors)
  turn = 0
  while turn < 10 && winner == false
    puts 'Please guess'
    breaker_guess = breaker_guess()
    guesses.push(breaker_guess)
    winner = check_winner(computer_code, breaker_guess)
    breaker_guess

    turn += 1
  end
  print 'Winner!' if winner == true
end

start_game
