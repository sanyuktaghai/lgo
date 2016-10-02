class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :stories  
  has_many :story_likes
  has_many :bookmarks
  has_many :followings
  has_many :followers, through: :followings, class_name: "User"
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  def full_name
    f_name = self.first_name.titleize.gsub(/\b\w/) { |w| w.upcase }
    l_name = self.last_name.titleize.gsub(/\b\w/) { |w| w.upcase }
    "#{f_name} #{l_name}"
  end

  def follows_or_same?(follow)
#    Following.where(user_id: follow.id).include?(follower_id: self.id) || self == follow
#    followings.map(&:user).include?(follow) || self == follow
#        followings.map(&:follower).include?(new_follow) || self == new_follow
#        followings.map(&:follower).include?(follow) || self == follow
#    followings.map(&:user).include?(follow)
    Following.where(follower_id: self.id).where(user_id: follow.id).empty? || self == follow
  end
end