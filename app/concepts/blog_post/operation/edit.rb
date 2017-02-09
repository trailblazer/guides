require 'trailblazer'

#:editop
require_relative "../contract/edit"
require_relative "../lib/error"

class BlogPost::Edit < Trailblazer::Operation 
  step Model(BlogPost, :find_by)
  failure BlogPost::Error
  step Policy::Guard(:signed_in!)
  step Policy::Guard(:authorize!)
  step Contract::Build( constant: BlogPost::Contract::Edit )

  def signed_in!(options, current_user:, **)
    current_user == nil ? false : current_user.singed_in
  end

  def authorize!(options, current_user:, model:, **)
    current_user == nil ? false : (current_user.id == model.user_id or current_user.email == "admin@email.com")
  end 
end
#:editop end