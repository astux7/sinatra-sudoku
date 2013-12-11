require 'sinatra'
require_relative './lib/sudoku'
require_relative './lib/cell'
require_relative './lib/puzzle'
 
enable :sessions
 
def random_sudoku
  seed = (1..9).to_a.shuffle + Array.new(81-9, 0)
  sudoku = Sudoku.new(seed.join)
  sudoku.solve!
  sudoku.to_s.chars
end

def inspects
    @current_solution.each_with_index {|row, index|
      print row.to_s+' '
      print "\n" if (index+1)%9==0
    }
end
# this method removes some digits from the solution to create a puzzle
def puzzle(sudoku)
  # this method is yours to implement
  puzz = Puzzle.new(sudoku.dup)
  puzz.generate_puzzle(:easy)
end

get '/' do
  sudoku = random_sudoku
  session[:solution] = sudoku
  #print sudoku
  session[:puzzle] = puzzle(sudoku)
  session[:current_solution] = nil  
  @current_solution = session[:current_solution] || session[:puzzle]
 # inspects
  erb :index
end

get '/solution' do
  @current_solution = session[:solution]
 # inspects
  erb :index
end