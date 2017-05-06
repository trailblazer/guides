#:showop
class BlogPost::Show < Trailblazer::Operation
  step Model(BlogPost, :find_by) # why find_by
end
#:showop end
