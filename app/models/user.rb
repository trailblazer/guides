#:model
class User < ActiveRecord::Base
  has_many :blog_post
end
#:model end
