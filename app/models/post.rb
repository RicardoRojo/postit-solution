class Post < ActiveRecord::Base
  include VoteableRic
  include Sluggeable

  belongs_to :creator, foreign_key: "user_id", class_name: "User"
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true
  validates :url, presence: true

  slugged_column :title

end