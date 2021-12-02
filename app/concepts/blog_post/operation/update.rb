#:update
module BlogPost::Operation
  class Update < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(BlogPost, :find_by)
      step Contract::Build(constant: BlogPost::Contract::Create)
    end

    step Subprocess(Present)
    step Contract::Validate(key: :blog_post)
    step Contract::Persist()
  end
end
#:update end
