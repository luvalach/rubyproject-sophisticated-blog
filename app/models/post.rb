class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable 
  has_and_belongs_to_many :tags
end
