# search.py
# ---------
# Licensing Information:  You are free to use or extend these projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to UC Berkeley, including a link to http://ai.berkeley.edu.
# 
# Attribution Information: The Pacman AI projects were developed at UC Berkeley.
# The core projects and autograders were primarily created by John DeNero
# (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# Student side autograding was added by Brad Miller, Nick Hay, and
# Pieter Abbeel (pabbeel@cs.berkeley.edu).


"""
In search.py, you will implement generic search algorithms which are called by
Pacman agents (in searchAgents.py).
"""

import util

class SearchProblem:
    """
    This class outlines the structure of a search problem, but doesn't implement
    any of the methods (in object-oriented terminology: an abstract class).

    You do not need to change anything in this class, ever.
    """

    def getStartState(self):
        """
        Returns the start state for the search problem.
        """
        util.raiseNotDefined()

    def isGoalState(self, state):
        """
          state: Search state

        Returns True if and only if the state is a valid goal state.
        """
        util.raiseNotDefined()

    def expand(self, state):
        """
          state: Search state

        For a given state, this should return a list of triples, (child,
        action, stepCost), where 'child' is a child to the current
        state, 'action' is the action required to get there, and 'stepCost' is
        the incremental cost of expanding to that child.
        """
        util.raiseNotDefined()

    def getActions(self, state):
        """
          state: Search state

        For a given state, this should return a list of possible actions.
        """
        util.raiseNotDefined()

    def getActionCost(self, state, action, next_state):
        """
          state: Search state
          action: action taken at state.
          next_state: next Search state after taking action.

        For a given state, this should return the cost of the (s, a, s') transition.
        """
        util.raiseNotDefined()

    def getNextState(self, state, action):
        """
          state: Search state
          action: action taken at state

        For a given state, this should return the next state after taking action from state.
        """
        util.raiseNotDefined()

    def getCostOfActionSequence(self, actions):
        """
         actions: A list of actions to take

        This method returns the total cost of a particular sequence of actions.
        The sequence must be composed of legal moves.
        """
        util.raiseNotDefined()


def tinyMazeSearch(problem):
    """
    Returns a sequence of moves that solves tinyMaze.  For any other maze, the
    sequence of moves will be incorrect, so only use this for tinyMaze.
    """
    from game import Directions
    s = Directions.SOUTH
    w = Directions.WEST
    return  [s, s, w, s, w, w, s, w]



import math
class State:
    def __init__(self, problem, distance, state, action=None, cost=None, previous_state=None):
        self.problem = problem
        self.distance = distance
        self.state = state
        self.action = action
        self.cost = cost
        self.previous_state = previous_state
    def __hash__(self):
        return hash(self.state)
    def __eq__(self, other):
      if not isinstance(other, type(self)): return NotImplemented
      return self.state == other.state
    def is_goal(self):
        return self.problem.isGoalState(self.state)
    def expand(self):
        return self.problem.expand(self.state)
    def build(self, child):
        return State(self.problem, math.inf, child[0], child[1], child[2], self)
    def relax(self, child):
        new_distance = child.cost+self.distance
        if new_distance >= child.distance:
            return False
        child.distance = new_distance
        child.previous_state = self
        return True
    def reconstruct_path(self):
        path = []
        node = self
        while node.action is not None:
              path.insert(0, node.action)
              node = node.previous_state
        return path

class Frontier:
    def pop():
        util.raiseNotDefined()
    def push(state):
        util.raiseNotDefined()
    def isEmpty():
        util.raiseNotDefined()

class AStarFrontier(Frontier):
    def __init__(self, problem, heuristic):
        self.heuristic = heuristic
        self.problem = problem
        self.queue = util.PriorityQueue()
    def pop(self):
        return self.queue.pop()
    def isEmpty(self):
        return self.queue.isEmpty()
    def push(self,state):
        estimatedForwardCost = state.distance + self.heuristic(state.state, self.problem)
        return self.queue.push(state, estimatedForwardCost)

def findPlanFor(problem, frontier):
    frontier.push(State(problem,0,problem.getStartState()))
    visited = set()
    while not frontier.isEmpty():
        state = frontier.pop()
        if state.is_goal():
            return state.reconstruct_path()
        if state not in visited:
            visited.add(state)
            for child in state.expand():
                new_state = state.build(child)
                state.relax(new_state)
                frontier.push(new_state)
    return []


def depthFirstSearch(problem):
    """
    Search the deepest nodes in the search tree first.

    Your search algorithm needs to return a list of actions that reaches the
    goal. Make sure to implement a graph search algorithm.

    To get started, you might want to try some of these simple commands to
    understand the search problem that is being passed in:

    print("Start:", problem.getStartState())
    print("Is the start a goal?", problem.isGoalState(problem.getStartState()))
    """
    return findPlanFor(problem, util.Stack())

def breadthFirstSearch(problem):
    """Search the shallowest nodes in the search tree first."""
    return findPlanFor(problem, util.Queue())

def nullHeuristic(state, problem=None):
    """
    A heuristic function estimates the cost from the current state to the nearest
    goal in the provided SearchProblem.  This heuristic is trivial.
    """
    return 0

def aStarSearch(problem, heuristic=nullHeuristic):
    """Search the node that has the lowest combined cost and heuristic first."""
    return findPlanFor(problem, AStarFrontier(problem, heuristic))


# Abbreviations
bfs = breadthFirstSearch
dfs = depthFirstSearch
astar = aStarSearch
