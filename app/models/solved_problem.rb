class SolvedProblem < ActiveRecord::Base
  belongs_to :user
  belongs_to :problem
  attr_accessible :given_answer, :solved_at, :problem_id
end
