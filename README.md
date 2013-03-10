NQueens Solver    
===

This is a app to play around with some code for visualizing, comparing, and running NQueens problems. I have always found the problem interesting and I have solved it in a number of languages. The current solution code is some of the very first Ruby I wrote while learning the language. I want to add a way for users to interact with the problem and visualize the organization / code paths while solving the problem.

__To Run Locally__

`bundle exec rackup -p 3000`

__TODO__

  * Generate Random Boards, and have user interact before solving
  * After Random board is displayed the user can drag / move around the queens
  * User can click a button to trigger a NQueens solver, which will display the solved board and some information about the runtime of the solution
  * User can trigger multiple solves to see a comparison report
  * Integrate with deferred_server as a runner
  * Allow queueing of larger N-queen problems to be solved
  * Allow visualization of more than jut a 8*8 chess board / problem results
