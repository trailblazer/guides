#:createop
class BlogPost::Create < Trailblazer::Operation
  #:newop
  class Present < Trailblazer::Operation
    step Trailblazer::Operation::Policy::Guard( :authorize! )
    step Model(BlogPost, :new)
    step Contract::Build( constant: BlogPost::Contract::Create )

    def authorize!(options, current_user:, **)
      current_user == nil ? false : current_user.signed_in
    end
  end
  #:newop end

  step Nested( Present )
  step Contract::Validate( )
  step Contract::Persist( )
  step :notify!

  def notify!(options, current_user:, model:, **)
    options["result.notify"] = BlogPost::Notification.(current_user, model)
  end
end
#:createop end
