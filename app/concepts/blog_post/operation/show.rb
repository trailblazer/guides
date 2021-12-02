#:showop
module BlogPost::Operation
  class Show < Trailblazer::Operation
    step Model(BlogPost, :find_by)
  end
end
#:showop end
