class Rating < ActiveRecord::Base
  belongs_to :user
  attr_accessible :problems_solved, :problems_posted
end
