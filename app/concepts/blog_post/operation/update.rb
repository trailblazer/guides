#:update
# app/concepts/blog_post/operation/update.rb
module BlogPost::Operation
  class Update < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(BlogPost, :find_by)
      step Contract::Build(constant: BlogPost::Contract::Create)
    end

    #~up
    step Subprocess(Present)
    step Contract::Validate(key: :blog_post)
    step Contract::Persist()
    #~up end
  end
end
#:update end
