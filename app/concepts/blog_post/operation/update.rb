require 'trailblazer/operation'

#:createop
require_relative "../lib/notification"
require_relative "../operation/edit"

class BlogPost::Create < Trailblazer::Operation
  step Nested(BlogPost::Edit)
  step Contract::Validate()
  step Contract::Persist()
  step :notify!

  def notify!(options, current_user:, model:, **)
    options["result.notify"] = BlogPost::Notification.(current_user, model)
  end
end
#:createop end
