class CreateBlogPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.string :body
      t.string :author
      t.integer :user_id
    end
  end
end
