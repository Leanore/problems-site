class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :services, :dependent => :destroy
  has_many :problems
  has_many :solved_problems
  has_one :profile, :dependent => :destroy
  has_one :rating, :dependent => :destroy
  after_create :build_profile_and_rating

  attr_accessible :login, :email, :password, :password_confirmation, :remember_me, :confirmed_at, :profile

  validates_presence_of :login, :email
  #validate :if_password_not_empty, :confirm_pass

  validates_confirmation_of :password

  def password_required?
    if !persisted?
      false
      !(password != "")
    else
      !password.nil? || !password_confirmation.nil?
    end
  end

=begin
  def if_password_not_empty
    !self.password.blank?
  end

  def confirm_pass
    self.password == self.password_confirmation
  end
=end

  def build_profile_and_rating
    self.build_profile
    self.build_rating
    self.save!
  end

  def add_service_profile_rating(auth)
    self.services.create :provider => auth.provider, :uid => auth.uid, :uname => auth.info.nickname, :uemail => auth.info.email
    self.build_profile :fullname =>  auth.info.name, :location => auth.info.location, :shortbio => auth.info.description, :avatar => auth.info.image
    self.build_rating
    self.profile.save
    self.rating.save
    self.save!
  end

  def add_solved_problem(problem, answer)
    self.solved_problems.build :given_answer => answer, :solved_at => DateTime.now, :problem_id => problem.id
    self.increment_rating_solved
    self.save!
  end

  def increment_rating_posted
    self.rating.problems_posted = self.rating.problems_posted + 1
    self.rating.save!
  end

  def increment_rating_solved
    self.rating.problems_solved = self.rating.problems_solved + 1
    self.rating.save!
  end

  def self.create_with_omni(auth)
    User.create do |user|
      auth.info.email ? email = auth.info.email : email = "#{auth.info.nickname}@please-change.me"
      user.email = email
      user.login = auth.info.nickname
      user.skip_confirmation!
      user.confirm!
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && services.nil?
  end

  def email_required?
    super && services.nil?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end


  def self.solve_rating(name)
    user = User.find_by_login(name)
    res_rating = user.rating.problems_solved + user.rating.problems_posted
  end

  def self.get_top_users_and_ratings
    logins_ratings_array = []
    User.all.each do |user|
      logins_ratings_array.push("[" + user.login.to_s + "," + user.solve_rating.to_s + "],")
    end
    logins_ratings_array
  end

  def self.get_top_users
    #array = []
    #User.all.each do |user|
    #  array.push(user.login.to_s)
    #end
    #return array
    hash = {}
    User.all.each do |user|
      hash[user.login] = user.rating.problems_solved + user.rating.problems_posted
    end
    return hash
  end

  self.per_page = 5
end
