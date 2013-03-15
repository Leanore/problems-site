class LogItemsController < ApplicationController
  def index
    @log_items = LogItem.all
  end
end
