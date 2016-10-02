class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :stories  
  has_many :story_likes
  has_many :bookmarks
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  def full_name
    "#{self.first_name.titleize.gsub(/\b\w/) { |w| w.upcase }} #{self.last_name.titleize.gsub(/\b\w/) { |w| w.upcase }}"
  end
end