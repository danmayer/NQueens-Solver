require 'json'
require './lib/utils'
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

get '/' do
  @prob = NQueensProblem.new(BOARD_SIZE)
  @prob.random_state
  @available_searches = %w(breadth_first_tree_search depth_first_tree_search breadth_first_graph_search depth_first_graph_search iterative_deepening_search)  
  erb :index
end

post '/solve' do
  @prob = NQueensProblem.new(BOARD_SIZE)
  @inst_prob = InstrumentedProblem.new(@prob)
  
  case params['search_type']
  when 'breadth_first_tree_search'
    breadth_first_tree_search(@inst_prob)
  when 'depth_first_tree_search'
    depth_first_tree_search(@inst_prob)
  when 'breadth_first_graph_search'
    breadth_first_graph_search(@inst_prob)
  when 'depth_first_graph_search'
    depth_first_graph_search(@inst_prob)
  when 'iterative_deepening_search'
    iterative_deepening_search(@inst_prob)
  else
    iterative_deepening_search(@inst_prob)
  end

  @inst_prob.to_hash.to_json
end

private

def board_size
  BOARD_SIZE
end
