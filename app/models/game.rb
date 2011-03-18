class Game < ActiveRecord::Base

def compare(a_guess, the_number)
a_guess = a_guess.to_i
the_number = the_number.to_i

puts "comparing your guess #{a_guess} to the random number #{the_number}"

@message = 'compare'
case 
when a_guess == the_number then @message = 'true'
when a_guess > the_number then @message = 'lower'
when a_guess < the_number then @message = 'higher'
end
puts @message
return @message

end

end
