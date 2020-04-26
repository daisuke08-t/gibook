class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  
  has_secure_password
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password, presence: true, length: { in: 8..32 }, format: { with: VALID_PASSWORD_REGEX }, allow_nil: true
  
  has_many :topics
  
  has_many :favorites
  has_many :favorite_topics, through: :favorites, source: 'topic'
  
  has_many :comments
  has_many :comment_topics, through: :comments, source: 'topic'
  
  
  has_many :active_follows, class_name: "Follow", #どのクラスと関連づけるかを明示
                            foreign_key: "follower_id",
                            dependent: :destroy
  
  has_many :passive_follows, class_name: "Follow",
                             foreign_key: "followed_id",
                             dependent: :destroy
  
  has_many :following, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower
  
  has_many :books
  
  mount_uploader :icon, ImageUploader
  
  
  
  
  #ユーザーをフォロー
  def follow(other_user)
    active_follows.create(followed_id: other_user.id)
  end
  #ユーザーのフォーロー解除
  def unfollow(other_user)
    active_follows.find_by(followed_id: other_user.id).destroy
  end
  #引数のユーザーをフォローしているか？していればtrue
  def following?(other_user)
    following.include?(other_user)
  end
  
end
