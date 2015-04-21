module Sluggeable
  extend ActiveSupport::Concern

  included do
    after_validation :add_slug!
    class_attribute :slug_col
  end


  def to_param
    self.slug
  end

  def add_slug!
    the_slug = to_slug(self.send(slug_col.to_sym))
    post = self.class.find_by(slug: the_slug)
    count = 2
    while post && post != self
      the_slug = append_suffix(the_slug, count)
      post = self.class.find_by(slug: the_slug)
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

  module ClassMethods
    def slugged_column(column)
      self.slug_col = column
    end
  end
end