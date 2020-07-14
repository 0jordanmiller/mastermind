require 'colorize'

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

def randomize_pegs
  arr = []
  4.times  {|i| arr.push(i) }
  arr.shuffle
end

def color_switch(color, circle_size)
  if circle_size == true
    circle = '⬤'
  else
    circle = '●'
  end
  case color
    when 'R'
      color = circle.red
    when 'G'
      color = circle.green
    when 'B'
      color = circle.blue
    when 'W'
      color = circle.white
    when 'Y'
      color = circle.yellow
    when 'P'
      color = circle.magenta
    when nil
      color = '○'
  end
end

def print_board(colors, peg_order)
  print "Guesses: \n"
    i = 0
    j = 0
    while  j < 4
        while i < colors.length
        color = color_switch(colors[i][0][j], true)
        print color
        print '            '
        i += 1
          if i == colors.length
            puts ''
          end
        end
    i = 0
    j += 1
  end
  print "\nPegs: \n"

    k = 0
    l = 0
    while  l < 4
        while k < colors.length
          peg = color_switch(colors[k][1][peg_order[l]], false)
          print peg
          print '            '
          if k + 1 == colors.length
            puts ''
          end
        k += 1
        end
    k = 0
    l += 1
  end
end

def feedback(code_maker, code_breaker)
  red_accounted = [false, false, false, false]
  white_accounted = [false, false, false, false]
  pegs = {}

  # red
  code_maker.chars.each.with_index do |maker_letter, i|
    if maker_letter == code_breaker[i] 
      red_accounted[i] = true
      pegs[i] = 'R'
    end
  end

  # white
  code_maker.chars.each.with_index do |maker_letter, i|
    code_breaker.chars.each.with_index do |breaker_letter, j|
      if maker_letter == breaker_letter && red_accounted[i] == false && white_accounted[j] == false && red_accounted[j] == false
        white_accounted[j] = true
        pegs[j] = 'W'
        break
      end
    end
  end
  pegs
end

def start_game
  peg_order = randomize_pegs
  winner = false
  puts 'Try and break the code. Input four colors, Red, Green, Blue, Yellow, White, Purple. Sample input: RGBWY. '
  guesses = []
  # maker_code = computer_code(colors)
  # maker_code.chars.each {|code| print code}
  print "PWRY"
  turn = 0
  while turn < 10 && winner == false
    print "\nPlease guess: "
    breaker_guess = breaker_guess()
    winner = "PWRY" == breaker_guess
    if winner == true
      break
    end
    guesses.push([breaker_guess, feedback("PWRY", breaker_guess)])
    print_board(guesses, peg_order)
    p guesses
    turn += 1
  end
  print 'Winner!' if winner == true
end

start_game
