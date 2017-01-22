require "rspec"

require "active_record"

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db.sqlite3',
)

ActiveRecord::Schema.define do
  create_table :blog_posts, force: true do |t|
    t.string :title
    t.string :body
    t.string :author
  end
end

