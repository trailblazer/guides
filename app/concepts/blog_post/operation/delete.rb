require 'trailblazer/operation'

#:deleteop
require_relative "../lib/error"
require_relative "../lib/throw_exception"
require_relative "../lib/notification"

class BlogPost::Delete < Trailblazer::Operation
  step Model(BlogPost, :find_by)
  failure BlogPost::Error, fail_fast: true
  step Policy::Guard(:authorize!)
  failure BlogPost::ThrowException
  step :notify!
  step :delete!

  def authorize!(options, current_user:, model:, **)
    current_user == nil ? false : ((current_user.id == model.user_id) or (current_user.email == "admin@email.com"))
  end 

  def notify!(options, current_user:, model:, **)
    options["result.notify"] = BlogPost::Notification.(current_user, model)
  end

  def delete!(options, model:, **) 
    model.destroy
  end 

end
#:deleteop end