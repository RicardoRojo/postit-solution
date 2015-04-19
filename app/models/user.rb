class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  has_secure_password validations: false

  after_validation :add_slug

  validates :username, uniqueness: true, presence: true, length: {minimum: 3, maximum: 20}
  validates :password, presence: true, length: {minimum: 5, maximum: 20}, on: :create

  def to_param
    self.slug
  end

  def add_slug
    self.slug = self.username
  end
end