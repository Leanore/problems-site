class HomeController < ApplicationController
  def index
    @users = User.all
    @tags = Problem.tag_counts_on(:tags)
  end
end
