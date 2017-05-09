#:update
class BlogPost::Update < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(BlogPost, :find_by)
    step Contract::Build( constant: BlogPost::Contract::Create )
  end

  step Nested(Present)
  step Contract::Validate( key: :blog_post )
  step Contract::Persist()
end
#:update end
