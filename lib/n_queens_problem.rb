#  The problem of placing N queens on an NxN board with none attacking
#    each other.  A state is represented as an N-element array, where the
#    a value of r in the c-th entry means there is a queen at column c,
#    row r, and a value of None means that the c-th column has not been
#    filled in yet.  We fill in columns left to right.
class NQueensProblem < Problem 
  
  attr_accessor :n_queens, :initial
  
  def initialize(n_queens, initial_state = nil)
    @n_queens = n_queens
    @initial = initial_state.nil? ? Array.new(n_queens) : initial_state
  end

  def random_state
    (0...@n_queens).to_a.each do |row|
      @initial[row] = rand(@n_queens)
    end
  end

  def successor(state) 
    #"In the leftmost empty column, try all non-conflicting rows."
    if state[(state.length-1)] != nil
      return [] # All columns filled; no successors
    else
      def place(col, row, state)
        new = Array.new(state) #.copy # copy the state
        new[col] = row
        return new
      end
      col = state.index(nil)
      attempts = []
      if col!=nil
        (0...@n_queens).to_a.each do |row|
          attempts << [row, place(col, row, state)] if !conflicted(state, row, col)
        end
      end
      return attempts
    end
  end
                    
  def conflicted(state, row, col)
    #"Would placing a queen at (row, col) conflict with anything?"
    if col!=nil
      (0...col).to_a.each do |c|
        #bpoint
        return true if conflict(row, col, state[c], c)        
      end
    end
    return false
  end
          
  #"Would putting two queens in (row1, col1) and (row2, col2) conflict?"
  ## same row  ## same column ## same \ diagonal ## same / diagonal
  def conflict(row1, col1, row2, col2)
    return (row1 == row2 || col1 == col2 || row1-col1 == row2-col2 || row1+col1 == row2+col2) 
  end
    
  def goal_test(state)
    #"Check if all columns filled, no conflicts."
    return false if state[(state.length-1)] == nil 
    (0...state.length).to_a.each do |c|
      return false if conflicted(state, state[c], c)               
    end
    return true
  end
    
end
