require 'sinatra'
require 'sinatra/reloader'

get '/'  do
	number = rand(100)
	guess = params['guess'].to_s
	erb :index, :locals => {:number => number.to_s, :guess => guess}
end