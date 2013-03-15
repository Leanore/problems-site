class Problem < ActiveRecord::Base
  belongs_to :user
  has_many :answers, :dependent => :destroy
  has_many :solved_problems

  acts_as_taggable_on :tags
  accepts_nested_attributes_for :answers, :allow_destroy => true, :reject_if => :all_blank

  attr_accessor :answer
  attr_accessible :description, :posted_date, :solved_times, :title, :user_id, :tag_list, :answers, :answers_attributes

  validates_presence_of :title, :description, :answers

  self.per_page = 5

  define_index do
    indexes :description
    indexes :title
    indexes :posted_date, sortable: true, desc: true
    indexes taggings.tag.name, :as => :tags
    indexes [user.login, user.profile.fullname], as: :user_name
  end

  def self.all_cached
    Rails.cache.fetch('Problem.all') { all }
  end

  def self.solved_a_day(date)
    where("date(posted_date) = ?",date).sum(:solved_times)
  end

  def self.posted_a_day(date)
    where("date(posted_date) = ?",date).sum(1)
  end

  def increment_solved_times
    self.solved_times = self.solved_times + 1
    self.save!
  end
end
