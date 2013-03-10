class Node
  #    """A node in a search tree. Contains a pointer to the parent (the node
  #    that this is a successor of) and to the actual state for this node. Note
  #    that if a state is arrived at by two paths, then there are two nodes with
  #    the same state.  Also includes the action that got us to this state, and
  #    the total path_cost (also known as g) to reach the node.  Other functions
  #    may add an f and h value; see best_first_graph_search and astar_search for
  #    an explanation of how the f and h values are handled. You will not need to
  #    subclass this class."""
  attr_accessor :state, :parent, :action, :path_cost, :depth
  
  def initialize(state, parent=nil, action=nil, path_cost=0)
    #        "Create a search tree Node, derived from a parent by an action."
    #    update(state=state, parent=parent, action=action, 
    #      path_cost=path_cost, depth=0)
    @state=state
    @parent=parent
    @action=action 
    @path_cost=path_cost
    @depth=0
    @depth = parent.depth + 1 if parent
  end
            
            
  def repr()
    return "<Node %s>" % (@state)
  end
    
  def path()
    #        """Create a list of nodes from the root to this node."""
    # Isn't this backwards???
    x, result = self, [self]
    while x.parent
      result.append(x.parent)
      x = x.parent
    end
    return result
  end

  #TODO this could be wrong go over again
  def expand(problem)
    #        "Return a list of nodes reachable from this node. [Fig. 3.8]"
    expand = []
    #bpoint
    problem.successor(@state).each do | action_succ |
      act = action_succ[0]
      next_act = action_succ[1]
      expand << Node.new(next_act, self, act,problem.path_cost(@path_cost, @state, act, next_act))
    end
    return expand
  end

end
