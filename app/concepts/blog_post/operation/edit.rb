require 'trailblazer'

#:editop
require_relative "../contract/edit"
require_relative "../lib/error"
require_relative "../lib/throw_exception"

class BlogPost::Edit < Trailblazer::Operation 
  step Model(BlogPost, :find_by)
  failure BlogPost::Error
  step Policy::Guard(:signed_in!)
  failure :flash_message!, fail_fast: true
  step :authorize!
  failure BlogPost::ThrowException
  step Contract::Build( constant: BlogPost::Contract::Edit )

  def signed_in!(options, current_user:, **)
    current_user == nil ? false : current_user.signed_in
  end

  def authorize!(options, current_user:, model:, **)
    (current_user.id == model.user_id) or (current_user.email == "admin@email.com")
  end 

  def flash_message!(options, *)
    # flash message    
    false
  end
end
#:editop end