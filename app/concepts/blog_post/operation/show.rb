#:showop
# app/concepts/blog_post/operation/show.rb
module BlogPost::Operation
  class Show < Trailblazer::Operation
    step Model(BlogPost, :find_by)
  end
end
#:showop end
