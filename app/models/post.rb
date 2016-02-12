class Post < ActiveRecord::Base
  acts_as_commentable
  belongs_to :user
  belongs_to :blog
  acts_as_commentable
  has_many :likes, as: :likeable
  has_and_belongs_to_many :tags


def all_tags=(names)
  self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
  end
end

def all_tags
  self.tags.map(&:name).join(", ")
end
end
