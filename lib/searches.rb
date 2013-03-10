def tree_search(problem, fringe)
  #    """Search through the successors of a problem to find a goal.
  #    The argument fringe should be an empty queue.
  #    Don't worry about repeated paths to a state. [Fig. 3.8]"""
  #    Since we dont worry about repeated paths this can lead to infinite loops
  fringe.append(Node.new(problem.initial))
  while fringe.len > 0
    node = fringe.pop()
    return node if problem.goal_test(node.state) if node
    fringe.extend(node.expand(problem)) if node
  end
  return nil
end

def breadth_first_tree_search(problem)
  #    "Search the shallowest nodes in the search tree first. [p 74]"
  return tree_search(problem, FIFOQueue.new)
end
    
def depth_first_tree_search(problem)
  #    "Search the deepest nodes in the search tree first. [p 74]"
  return tree_search(problem, Stack.new)
end

def graph_search(problem, fringe)
  #    """Search through the successors of a problem to find a goal.
  #    The argument fringe should be an empty queue.
  #    If two paths reach a state, only use the best one. [Fig. 3.18]"""
  closed = []
  fringe.append(Node.new(problem.initial))
  while fringe.len > 0
    node = fringe.pop()
    if node #loop wrong do we need these? len > 1?
      if problem.goal_test(node.state) 
        return node
      end
      if !closed.member?(node.state)
        closed << node.state
        fringe.extend(node.expand(problem))    
      end
    end
  end
  return nil
end

def breadth_first_graph_search(problem)
  #"Search the shallowest nodes in the search tree first. [p 74]"
  return graph_search(problem, FIFOQueue.new)
end
    
def depth_first_graph_search(problem)
  #    "Search the deepest nodes in the search tree first. [p 74]"
  return graph_search(problem, Stack.new)
end
  
#"[Fig. 3.12]"
# Would this not be more elegant with an exception instead of 'cutoff'?
# Or would an exception work better for the _successful_ case? ;-)
def recursive_dls(node, problem, limit)
  cutoff_occurred = false
  if problem.goal_test(node.state)
      return node
  elsif node.depth == limit
      return 'cutoff'
  else
    for successor in node.expand(problem)
      result = recursive_dls(successor, problem, limit)
      if result == 'cutoff'
        cutoff_occurred = true
      elsif result != nil
        return result
      end
    end
  end
  if cutoff_occurred
    return 'cutoff'
  else
    return nil
  end
end

def depth_limited_search(problem, limit=50)
  # Body of depth_limited_search:
  return recursive_dls(Node.new(problem.initial), problem, limit)
end

def iterative_deepening_search(problem)
  #    "[Fig. 3.13]"
  [0..656].each do |depth| # for depth in xrange(sys.maxint)
    result = depth_limited_search(problem, depth)
    if result!='cutoff'
      return result
    end
  end
end
