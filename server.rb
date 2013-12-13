require 'sinatra'
require 'sinatra/partial'
require 'rack-flash'

require_relative './helpers/application'
require_relative './lib/sudoku'
require_relative './lib/cell'
require_relative './lib/puzzle'
require_relative './lib/controler_lib'

use Rack::Flash
enable :sessions
set :partial_template_engine, :erb
set :session_secret, "secure cookie"

include ControlerLibrary



get '/' do
  type = params.key?("hard") ? :hard : :easy
  reload = params.empty? ? false : true
  show_sudoku_puzzle(type, reload)
  erb :index
end



get '/restart' do
   @current_solution = session[:puzzle]
   session[:check_solution] = nil
   session[:current_solution] = session[:puzzle]
   @solution = session[:solution]
   @puzzle = session[:puzzle]
   erb :index
end

get '/help' do
  erb :help
end

post '/' do
  # the cells in HTML are ordered box by box 
  # (first box1, then box2, etc),
  # so the form data (params['cell']) is sent using this order
  # However, our code expects it to be row by row, 
  # so we need to transform it.
  redirect to("/?easy") if !params["easy"].nil?
  redirect to("/?hard") if !params["hard"].nil?
  save_solution if !params["save_start"].nil?
  check_solution 
  redirect to("/")
end

get '/solution' do
  redirect to("/") if session[:solution].nil?
  show_solution
  erb :index
end