class ProblemsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  # GET /problems
  # GET /problems.json
  def index
    @problems = Problem.search(params[:search], order: :posted_date, :per_page => Problem.per_page, :page => params[:page])
    #@problems = Problem.all(order: :posted_date, :per_page => Problem.per_page, :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @problems }
    end
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
    @problem = Problem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @problem }
    end
  end

  # GET /problems/new
  # GET /problems/new.json
  def new
    @problem = Problem.new
    @problem.answers.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @problem }
    end
  end

  # GET /problems/1/edit
  def edit
    @problem = Problem.find(params[:id])
  end

  # POST /problems
  # POST /problems.json
  def create
    @problem = Problem.new(params[:problem])
    @problem.user_id = current_user.id
    @user = User.find(current_user.id)
    @user.increment_rating_posted

    respond_to do |format|
      if @problem.save
        @log_item = LogItem.create(:user_id => current_user.id, :content => "posted", :problem_id => @problem.id, :at => DateTime.now)
        @log_items = LogItem.all :order => "at DESC", :limit => LogItem.limit
        format.html { redirect_to @problem, notice: 'Problem was successfully created.' }
        format.json { render json: @problem, status: :created, location: @problem }
      else
        format.html { render action: "new" }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /problems/1
  # PUT /problems/1.json
  def update
    @problem = Problem.find(params[:id])

    respond_to do |format|
      if @problem.update_attributes(params[:problem])
        format.html { redirect_to @problem, notice: 'Problem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problems/1
  # DELETE /problems/1.json
  def destroy
    @problem = Problem.find(params[:id])
    @problem.destroy

    respond_to do |format|
      format.html { redirect_to problems_url }
      format.json { head :no_content }
    end
  end

  def solve
    @problem = Problem.find(params[:id])
    answer = params[:problem][:answer].to_s
    respond_to do |format|
      if @problem.answers.find_by_answer(answer)
        @user = User.find(current_user.id)
        @user.add_solved_problem(@problem, answer)
        @problem.increment_solved_times
        @log_item = LogItem.create(:user_id => current_user.id, :content => "solved", :problem_id => @problem.id, :at => DateTime.now)
        @log_items = LogItem.all :order => "at DESC", :limit => LogItem.limit
        flash[:notice] = "Congratulation! That's the correct answer!"
        format.js
      else
        flash[:error] = "That is not the right answer!"
        format.js
      end
    end
  end

end
