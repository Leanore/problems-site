class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load

  def load
    @log_items = LogItem.all(:order => "at DESC", :limit => LogItem.limit)
    @tags = Problem.tag_counts_on(:tags)
    if !current_user.nil?
      @theme = User.find_by_id(current_user.id).profile.theme
    else
      @theme = "dark"
    end
    if @theme == "dark"
      @menu =  "navbar-inverse"
    end
  end
end
