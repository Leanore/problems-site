require 'will_paginate/array'
class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @problems_posted = Problem.find_all_by_user_id @user.id, :order => "posted_date DESC", :limit => 5
    @problems_solved = @user.solved_problems.find :all, :order => "solved_at DESC", :limit => 5
  end

  def edit
    @user = User.find(params[:id])
    @profile = @user.profile
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.profile.update_attributes(params[:profile])
        format.html { redirect_to @user, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def posted_problems
    @user = User.find(params[:id])
    @problems_posted = Problem.find_all_by_user_id(@user.id, :order => "posted_date DESC").paginate(:page => params[:page], :per_page => Problem.per_page)
  end

  def solved_problems
    @user = User.find(params[:id])
    @problems_solved = @user.solved_problems.find(:all, :order => "solved_at DESC").paginate(:page => params[:page], :per_page => Problem.per_page)
  end

end