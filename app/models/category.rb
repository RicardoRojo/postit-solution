class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories
  validates :name, presence: true
  validates :name, length: {minimum: 3, maximum: 25}

  after_validation :add_slug!

  def to_param
    self.slug
  end

  def add_slug!
    the_slug = to_slug(self.name)
    category = Category.find_by(slug: the_slug)
    count = 2
    while category && category != self
      the_slug = append_suffix(the_slug, count)
      category = Category.find_by(slug: the_slug)
      count += 1
    end
    self.slug = the_slug.downcase
  end

  def append_suffix(str, count)
    if str.split("-").last.to_i != 0
      return str.split("-").slice(0...-1).join("-") + "-" + count.to_s
    else
      return str + "-" + count.to_s
    end
    
  end

  def to_slug(str)
    working_string = str.strip
    working_string.gsub! /\s*[^A-Za-z0-9]\s*/ , "-"
    working_string.gsub! /-+/ , "-"
    working_string.downcase
  end
end