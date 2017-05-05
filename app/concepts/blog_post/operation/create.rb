#:createop
class BlogPost::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(BlogPost, :new)
    step Contract::Build( constant: BlogPost::Contract::Create )
  end

  #~present
  step Nested( Present )
  step Contract::Validate( )
  step Contract::Persist( )
  step :notify!

  def notify!(options, current_user:, model:, **)
    options["result.notify"] = BlogPost::Notification.(current_user, model)
  end
  #~present end
end
#:createop end
