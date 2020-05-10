class User < ApplicationRecord
  attr_accessor :remember_token
  
  validates :name, presence: true, length: { maximum: 15 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  
  has_secure_password
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password, presence: true, length: { in: 8..32 }, format: { with: VALID_PASSWORD_REGEX }, allow_nil: true
  
  has_many :topics, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  has_many :favorite_topics, through: :favorites, source: 'topic'
  
  has_many :comments, dependent: :destroy
  has_many :comment_topics, through: :comments, source: 'topic'
  
  
  has_many :active_follows, class_name: "Follow", #どのクラスと関連づけるかを明示
                            foreign_key: "follower_id",
                            dependent: :destroy
  
  has_many :passive_follows, class_name: "Follow",
                             foreign_key: "followed_id",
                             dependent: :destroy
  
  has_many :following, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower
  
  has_many :books, dependent: :destroy
  
  mount_uploader :icon, ImageUploader
  
  
  #渡された文字列のハッシュを返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  #ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  #永続セッションのためにユーザーをデータベースに記憶
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  #渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  #記憶トークンを破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
  
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
