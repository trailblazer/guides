#:newop
require_relative "../contract/create"

class BlogPost::New < Trailblazer::Operation 
  step Policy::Guard(:authorize!)
  step Model(BlogPost, :new) 
  step Contract::Build( constant: BlogPost::Contract::Create )

  def authorize!(options, current_user:, **)
    current_user.signed_in?
  end 
end
#:newop end