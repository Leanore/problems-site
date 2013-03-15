class TagsController < ApplicationController
  def index
    @tags = Problem.tag_counts_on(:tags)
  end

  def tag
    @problems = Problem.tagged_with(params[:id]).paginate(:page => params[:page], :per_page => Problem.per_page)
  end

end
