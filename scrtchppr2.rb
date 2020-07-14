require 'colorize'
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


peg_order = randomize_pegs

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

print_board([["BPRY", {2=>"R", 3=>"R", 1=>"W"}], ["PWYR", {0=>"R", 1=>"R", 3=>"W", 2=>"W"}]], peg_order)


