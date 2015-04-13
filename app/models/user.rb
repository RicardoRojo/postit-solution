class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password validations: false

  validates :username, uniqueness: true, presence: true, length: {minimum: 3, maximum: 20}
  validates :password, presence: true, length: {minimum: 5, maximum: 20}
end