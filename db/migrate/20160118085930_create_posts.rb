class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.references :user, index: true, foreign_key: true
      t.references :blog, index: true, foreign_key: true
      t.boolean :can_be_commented
      t.boolean :comments_needs_approval

      t.timestamps null: false
    end
  end
end
