class Profile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :fullname, :gender, :birth_date, :location, :shortbio, :avatar, :theme
end
