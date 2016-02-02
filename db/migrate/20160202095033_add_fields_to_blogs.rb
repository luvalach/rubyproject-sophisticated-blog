class AddFieldsToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :description, :string
    add_column :blogs, :publish, :boolean
    add_column :blogs, :commentable, :boolean
    add_column :blogs, :comment_needs_approval, :boolean
    add_index :blogs, :publish, unique: false
  end
end
