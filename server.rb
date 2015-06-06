require 'sinatra'
require 'sinatra/reloader'

$secret_number

def new_game
	$secret_number = (params['guess'] == nil || $secret_number == nil) ? rand(100) : $secret_number 
end

def get_locals
	number = $secret_number
	response = 'Guess any number between 0 and 100'
	correct = false
	guess = params['guess']

	if guess != nil
		guess = guess.to_i

		if guess > number
			difference = guess - number
			if difference > 5
				response = "Way too high."
			else
				response = "Too high."
			end
		elsif guess < number
			difference = number - guess
			if difference > 5
				response = "Way too low."
			else
				response = "Too low."
			end
		else
			response = "Correct!"
			correct = true
		end
	end

	{
		:number => number.to_s,
		:guess => guess.to_s,
		:response => response,
		:correct => correct
	}
end

get '/'  do
	new_game
	erb :index, :locals => get_locals
end