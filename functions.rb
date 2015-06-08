require_relative 'globals.rb'

def new_game
	if params['guess'] == nil || $secret_number == nil || $guesses < 1
		$secret_number = rand(100)
		$guesses = 5
	end
end

def get_locals
	number = $secret_number
	response = 'Guess any number between 0 and 100'
	correct = false
	guess = params['guess']
	proximities = {
		:far => '#FF3333',
		:close => '#FF9933',
		:correct => '#99FF66',
		:default => '#FFF'
	}
	proximity = proximities[:default];

	if guess != nil
		$guesses -= 1
		guess = guess.to_i

		if guess > number
			difference = guess - number
			if difference > 5
				response = "Way too high."
				proximity = proximities[:far]
			else
				response = "Too high."
				proximity = proximities[:close]
			end
		elsif guess < number
			difference = number - guess
			if difference > 5
				response = "Way too low."
				proximity = proximities[:far]
			else
				response = "Too low."
				proximity = proximities[:close]
			end
		else
			response = "Correct!"
			correct = true
			proximity = proximities[:correct]
		end
	end

	{
		:number => number.to_s,
		:guess => guess.to_s,
		:response => response,
		:cheat => (params['cheat'] == 'true'),
		:proximity => proximity,
		:correct => correct
	}
end