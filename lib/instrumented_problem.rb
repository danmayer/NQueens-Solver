class InstrumentedProblem < Problem
  #    """Delegates to a problem, and keeps statistics."""

  def initialize(problem) 
    @problem = problem
    @initial = problem.initial #shouldn't have to do this if method override correct
    @succs = @goal_tests = @states = 0
    @found = nil
  end
        
  def successor(state)
    #        "Return a list of (action, state) pairs reachable from this state."
    result =  @problem.successor(state)
    @succs += 1
    @states += result.length
    return result
  end
    
  def goal_test(state)
    #        "Return true if the state is a goal."
    @goal_tests += 1
    result = @problem.goal_test(state)
    @found = state if result 
            
    return result
  end
  
  #TODO doesn't work in ruby like python, besides method missing how in ruby?  
  #don't know what part of method calling to override to do this. Method missing doesn't work because
  # problem has .intial method, we need to catch calls on this object and if .initial pass to
  # problem.initial
  #  def getattr(attr)
  #    if['succs', 'goal_tests', 'states'].exist(attr)
  #      return self.send(attr)
  #    else
  #      return @problem.send(attr)
  #    end
  #  end 
  #   def method_missing(m, *args)
  #     puts "***************************************************"
  #     bpoint
  #     return @problem if m=='problem'
  #     return @problem.send(m) if @problem
  #   end  
  
  def found
    return @found
  end

  def to_s
    return "successors | goal tests | states | found \n"+'<%4d/%4d/%4d/%s>' % [@succs, @goal_tests, @states, ' true'] if @found!=nil
    return "successors | goal tests | states | found \n"+'<%4d/%4d/%4d/%s>' % [@succs, @goal_tests, @states, ' false'] if @found==nil
    # str(@found)[0:4])
  end
 
end
