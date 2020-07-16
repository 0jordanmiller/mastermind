# frozen_string_literal: true

require 'colorize'
require 'tty-prompt'

def colors
  %w[R G B Y W P]
end

def computer_code(colors)
  code = 4.times.map { colors[rand(6)] }
  code.join
end

def make_break_code(prompt_question)
  prompt = TTY::Prompt.new
  prompt.ask(prompt_question) do |q|
    q.required true
    q.validate(/\A[RGBYWP][RGBYWP][RGBYWP][RGBYWP]\z/, 'Please input a valid combination of four colors e.g. RGBW: ')
  end
end

def player_computer
  prompt = TTY::Prompt.new
  choices = [{ name: 'Player vs. Player', value: true }, { name: 'Player vs. Computer', value: false }]
  prompt.select('Play against the computer or another player?', choices)
end

def randomize_pegs
  arr = []
  4.times { |i| arr.push(i) }
  arr.shuffle
end

def color_switch(color, circle_size)
  circle = if circle_size == true
             '⬤'
           else
             '●'
           end
  case color
  when 'R'
    circle.red
  when 'G'
    circle.green
  when 'B'
    circle.blue
  when 'W'
    circle.white
  when 'Y'
    circle.yellow
  when 'P'
    circle.magenta
  when nil
    '○'
  end
end

def print_board(colors, peg_order)
  print "Guesses: \n"
  print_color_loop(0, colors, true, [0, 1, 2, 3])
  print_color_loop(1, colors, false, peg_order)
end

def print_color_loop(guess_peg, colors, circle_size, peg_order)
  big_space = '            '
  i = 0
  j = 0
  while j < 4
    while i < colors.length
      color = color_switch(colors[i][guess_peg][peg_order[j]], circle_size)
      print color
      print big_space
      i += 1
      puts '' if i == colors.length
    end
    i = 0
    j += 1
  end
end

def feedback(code_maker, code_breaker)
  red_accounted = [false, false, false, false]
  white_accounted = [false, false, false, false]
  pegs = {}

  code_maker.chars.each.with_index do |maker_letter, i|
    if maker_letter == code_breaker[i]
      red_accounted[i] = true
      pegs[i] = 'R'
    end
  end

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
  guesses = []
  turn = 0
  player_computer = player_computer()
  maker_code = if player_computer == false
                 computer_code(colors)
               else
                 make_break_code('Create a code for the opponent to break')
               end
  puts 'Try and break the code. Input four colors, Red, Green, Blue, Yellow, White, Purple. Sample input: RGBY. '
  print maker_code
  while turn < 10 && winner == false
    print "\nPlease guess: "
    make_break_code = make_break_code('Please guess a combination of 4 colors: ')
    winner = maker_code == make_break_code
    break if winner == true

    guesses.push([make_break_code, feedback(maker_code, make_break_code)])
    print_board(guesses, peg_order)
    p guesses
    turn += 1
  end
  print 'Winner!' if winner == true
end

start_game
