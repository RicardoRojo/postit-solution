class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories
  validates :name, presence: true
  validates :name, length: {minimum: 3, maximum: 25}

  after_validation :add_slug

  def to_param
    self.slug
  end

  def add_slug
    self.slug = self.name.downcase.gsub(" ","-")
  end
end