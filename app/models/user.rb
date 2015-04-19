class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  has_secure_password validations: false

  after_validation :add_slug!

  validates :username, uniqueness: true, presence: true, length: {minimum: 3, maximum: 20}
  validates :password, presence: true, length: {minimum: 5, maximum: 20}, on: :create

  def to_param
    self.slug
  end

  def add_slug!
    the_slug = to_slug(self.username)
    user = User.find_by(slug: the_slug)
    count = 2
    while user && user != self
      the_slug = append_suffix(the_slug, count)
      user = User.find_by(slug: the_slug)
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