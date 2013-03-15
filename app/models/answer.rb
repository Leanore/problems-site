class Answer < ActiveRecord::Base
  belongs_to :problem
  attr_accessible :answer
end
