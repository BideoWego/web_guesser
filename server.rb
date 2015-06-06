require 'sinatra'
require 'sinatra/reloader'

require_relative 'functions.rb'

get '/'  do
	new_game
	erb :index, :locals => get_locals
end