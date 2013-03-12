require 'json'
require 'fileutils'
require './lib/node'
require './lib/problem'
require './lib/n_queens_problem'
require './lib/instrumented_problem'
require './lib/searches'

set :public_folder, File.dirname(__FILE__) + '/public'
set :root, File.dirname(__FILE__)
enable :logging

INFINITY = 999999999999999999
BOARD_SIZE = 8

helpers do
end

#before { protected! if request.path_info == "/" && request.request_method == "GET" && ENV['RACK_ENV']!='test' }

get '/' do
  @prob = NQueensProblem.new(BOARD_SIZE)
  @prob.random_state
  erb :index
end

post '/solve' do
  @prob = NQueensProblem.new(BOARD_SIZE)
  @inst_prob = InstrumentedProblem.new(@prob)
  iterative_deepening_search(@inst_prob)
  {:results => @inst_prob.found}.to_json
end

private

def board_size
  BOARD_SIZE
end

def debug_env
  puts `which ruby`
end
