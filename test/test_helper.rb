# $LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'minitest/autorun'
require 'active_record'
require 'trailblazer/operation'

require_relative "../app/controllers/application_controller"

class MiniTest::Spec
  after do
    ::BlogPost.delete_all
  end
end

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db.sqlite3',
)

ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :email
    t.string :firstname
    t.boolean :signed_in
  end
end

ActiveRecord::Schema.define do
  create_table :blog_posts, force: true do |t|
    t.string :title
    t.string :body
    t.string :author
    t.integer :user_id
  end
end