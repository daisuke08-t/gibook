class Topic < ApplicationRecord
  validates :user_id, presence: true
  validates :title, presence: true
  #validates :content, presence: true
  
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: 'user'
  
  has_many :comments, dependent: :destroy
  has_many :comment_users, through: :comments, source: 'topic'
end
