require 'trailblazer/operation'

#:showop
require_relative "../lib/error"

class BlogPost::Show < Trailblazer::Operation
  step Model(BlogPost, :find_by) # why find_by
  failure BlogPost::Error

end
#:showop end