class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  
  has_many :stories  
  has_many :story_likes
  has_many :bookmarks
  has_many :followings
  has_many :followers, through: :followings, class_name: "User"
  
  cattr_accessor :form_steps do
#    %w(identity characteristics instructions)
    %w(basic_details)
  end
  
  attr_accessor :form_step
  
  def required_for_step?(step)
  # All fields are required if no form step is present
    return true if form_step.nil?

    # All fields from previous steps are required if the
    # step parameter appears before or we are on the current step
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end
#  validates :first_name, presence: true, if: -> {required_for_step?(:basic_details)}
#  validates :last_name, presence: true, if: -> {required_for_step?(:basic_details)}
  
  def full_name
    f_name = self.first_name.titleize.gsub(/\b\w/) { |w| w.upcase }
    l_name = self.last_name.titleize.gsub(/\b\w/) { |w| w.upcase }
    "#{f_name} #{l_name}"
  end
  
  def follows?(follow)
    Following.where(follower_id: self.id).where(user_id: follow.id).any?
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
  #    user.image = auth.info.image # assuming the user model has an image
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  def self.find_for_facebook_oauth(auth)
    user = User.where("(uid = ? AND provider = 'facebook') OR lower(email) = ?", auth.uid, auth.info.email).first

    user.provider = auth.provider
    user.uid = auth.uid

    user.save
    user
  end
  
end