#   code_maker.chars.each.with_index do |maker_letter, i|
#     code_breaker.chars.each.with_index do |breaker_letter, j|
#       puts maker_letter
#       p code_breaker_accounted
#       if maker_letter == breaker_letter && i == j && code_breaker_accounted[j] == false
#         red += 1
#         code_breaker_accounted[i] = true
#         break
#       elsif maker_letter == breaker_letter && code_breaker_accounted[j] == false
#         white += 1
#         code_breaker_accounted[j] = true
#         breaksssssz
#       elsif maker_letter == breaker_letter && i == j && code_breaker_accounted[j] == true
#         puts 'yes'
#         red += 1
#         white -= 1

#         break
#       end
#     end
#     p code_breaker_accounted
#   end
#   p "end of feedback: red: #{red} white: #{white}"
# end


        # p "Before: #{red_accounted}"
        # puts "white"
        # puts "#{i} #{maker_letter} #{red_accounted[i]}"
        # puts "#{j} #{breaker_letter}"
        # white_accounted[j] = true
        # white += 1
        # p "After Red Accounted: #{red_accounted}"
        # p "After White Accounted: #{white_accounted}"
