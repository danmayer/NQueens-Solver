class Problem
  #    """The abstract class for a formal problem.  You should subclass this and
  #    implement the method successor, and possibly __init__, goal_test, and
  #    path_cost. Then you will create instances of your subclass and solve them
  #    with the various search functions."""
  attr_accessor :initial, :goal
  
  def initialize(initial, goal=nil)
    #        """The constructor specifies the initial state, and possibly a goal
    #        state, if there is a unique goal.  Your subclass's constructor can add
    #        other arguments."""
    @initial = initial
    @goal = goal
  end
        
  def successor(state)
    #        """Given a state, return a sequence of (action, state) pairs reachable
    #        from this state. If there are many successors, consider an iterator
    #        that yields the successors one at a time, rather than building them
    #        all at once. Iterators will work fine within the framework."""
        
    #TODO how do you force code to be abstract in ruby
    #abstract
  end
    
  def goal_test(state)
    #        """Return True if the state is a goal. The default method compares the
    #        state to self.goal, as specified in the constructor. Implement this
    #        method if checking against a single self.goal is not enough."""
    return state == @goal
  end
    
  def path_cost(c, state1, action, state2)
    #        """Return the cost of a solution path that arrives at state2 from
    #        state1 via action, assuming cost c to get up to state1. If the problem
    #        is such that the path doesn't matter, this function will only look at
    #        state2.  If the path does matter, it will consider c and maybe state1
    #        and action. The default method costs 1 for every step in the path."""
    return c + 1
  end

  def value()
    #        """For optimization problems, each state has a value.  Hill-climbing
    #        and related algorithms try to maximize this value."""
    raise "child class must implement value"
  end

end
