ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/spec"

class MiniTest::Spec
  # after do
  #   ::BlogPost.delete_all
  # end
end

# ActiveRecord::Schema.define do
#   create_table :users, force: true do |t|
#     t.string :email
#     t.string :firstname
#     t.boolean :signed_in
#   end
# end

