class AddThemeToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :theme, :string, default: 'slate'
  end
end
