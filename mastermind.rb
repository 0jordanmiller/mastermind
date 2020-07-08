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

# def feedback_red(code_maker, code_breaker, pegs)
#     code_maker.chars.each.with_index do |maker_letter, i|
#     if maker_letter == code_breaker[i] 
#       red_accounted[i] = true
#       pegs[i] = 'red'
#     end
#   end
# end

def feedback(code_maker, code_breaker)
  red_accounted = [false, false, false, false]
  white_accounted = [false, false, false, false]
  pegs = {}


  # red
  code_maker.chars.each.with_index do |maker_letter, i|
    if maker_letter == code_breaker[i] 
      red_accounted[i] = true
      pegs[i] = 'red'
    end
  end

    # white
  code_maker.chars.each.with_index do |maker_letter, i|
    code_breaker.chars.each.with_index do |breaker_letter, j|

      if maker_letter == breaker_letter && red_accounted[i] == false && white_accounted[j] == false && red_accounted[j] == false
        white_accounted[j] = true
        white += 1
        pegs[i] = 'white'
        break
      end
    end
  end
  pegs
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
  print "PWRY"
  turn = 0
  while turn < 10 && guesses[-1] != true
    print "\nPlease guess: "
    breaker_guess = breaker_guess()
    guesses.push(breaker_guess)
    guesses.push(check_winner("PWRY", breaker_guess))
    # p guesses
    turn += 1
  end
  print 'Winner!' if winner == true
end

start_game
