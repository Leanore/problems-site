class LogItem < ActiveRecord::Base
  attr_accessible :user_id, :content, :problem_id, :at

  def self.limit
    5
  end
end
