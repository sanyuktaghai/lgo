class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :stories
#  has_many :stories_as_admin, class_name: 'Story'
#  has_many :stories_as_author, class_name: 'Story'
#  has_many :stories_as_poster, class_name: 'Story'
  
  has_many :story_likes
  has_many :bookmarks
  
end
