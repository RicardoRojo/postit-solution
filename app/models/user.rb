class User < ActiveRecord::Base
  include Sluggeable
  has_many :posts
  has_many :comments
  has_many :votes
  has_secure_password validations: false


  validates :username, uniqueness: true, presence: true, length: {minimum: 3, maximum: 20}
  validates :password, presence: true, length: {minimum: 5, maximum: 20}, on: :create

  slugged_column :username
end