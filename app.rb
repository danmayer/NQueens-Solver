require 'json'
require 'fileutils'
require './lib/node'
require './lib/problem'
require './lib/n_queens_problem'
require './lib/instrumented_problem'
require './lib/searches'

#use Rack::SslEnforcer unless ENV['RACK_ENV']=='test'
set :public_folder, File.dirname(__FILE__) + '/public'
set :root, File.dirname(__FILE__)
enable :logging

INFINITY = 999999999999999999

helpers do
  def protected!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Testing HTTP Auth")
      throw(:halt, [401, "Not authorized\n"])
    end
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['admin', 'responder']
  end
end

#before { protected! if request.path_info == "/" && request.request_method == "GET" && ENV['RACK_ENV']!='test' }

get '/' do
  prob = NQueensProblem.new(8)
  @inst_prob = InstrumentedProblem.new(prob)
  iterative_deepening_search(@inst_prob)
  erb :index
end

private

def iterative_deepening_search(problem)
  #    "[Fig. 3.13]"
  [0..656].each do |depth| # for depth in xrange(sys.maxint)
    result = depth_limited_search(problem, depth)
    if result!='cutoff'
      return result
    end
  end
end

def debug_env
  puts `which ruby`
end
