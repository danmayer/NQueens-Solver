# Delegates to a problem, and keeps statistics.
class InstrumentedProblem < Problem
  attr_accessor :initial
  
  def initialize(problem) 
    @problem = problem
    @initial = problem.initial #shouldn't have to do this if method override correct
    @succs = @goal_tests = @states = 0
    @found = nil
  end
        
  #        Return a list of (action, state) pairs reachable from this state.
  def successor(state)
    result =  @problem.successor(state)
    @succs += 1
    @states += result.length
    return result
  end
    
  #        Return true if the state is a goal.
  def goal_test(state)
    @goal_tests += 1
    result = @problem.goal_test(state)
    @found = state if result 
            
    return result
  end
  
  def found
    return @found
  end

  def to_hash
    {:found => @found, :successors => @succs, :goal_tests => @goal_tests, :states => @states}
  end

  def to_s
    if @found!=nil
      "successors | goal tests | states | found \n"+'<%4d/%4d/%4d/%s>' % [@succs, @goal_tests, @states, ' true']
    else
      "successors | goal tests | states | found \n"+'<%4d/%4d/%4d/%s>' % [@succs, @goal_tests, @states, ' false']
    end
  end
  
end
