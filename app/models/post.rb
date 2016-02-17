class Post < ActiveRecord::Base
  acts_as_commentable
  belongs_to :user
  belongs_to :blog
  acts_as_commentable
  has_many :likes, as: :likeable
  has_and_belongs_to_many :tags


def all_tags=(names)
    tag_names = names.split(/[\s,]+/).collect { |s| s.strip.downcase }.uniq
    n_or_f_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = n_or_f_tags
end

def all_tags
  self.tags.map(&:name).join(", ")
end
end
