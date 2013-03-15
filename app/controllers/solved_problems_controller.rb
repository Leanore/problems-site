class SolvedProblemsController < ApplicationController
  def new
    @solved_problem = SolvedProblem.new
  end

  def create
    answer = params[:given_answer]
    problem = Problem.find(params[:problem_id])
    if problem.answers.find(answer)
      @solved_problem = SolvedProblem.new(params[:solved_problem])
    end
  end
end
