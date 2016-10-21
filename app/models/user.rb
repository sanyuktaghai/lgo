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
    %w(basic_details)
  end
  
  attr_accessor :form_step
  
  validates :first_name, presence: true, if: :active?
  validates :last_name, presence: true, if: :active?
  
  def active?
    status == 'active'
  end

  
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
      user.image = auth.info.image
      user.age_range = auth.extra.raw_info.age_range
      user.gender = auth.extra.raw_info.gender
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