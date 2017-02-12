require 'trailblazer/operation'

#:createop
require_relative "../lib/notification"
require_relative "../operation/new"

class BlogPost::Create < Trailblazer::Operation
  step Nested(BlogPost::New)
  step Contract::Validate(key: :blog_post)
  step Contract::Persist()
  step :notify!

  def notify!(options, current_user:, model:, **)
    options["result.notify"] = BlogPost::Notification.(current_user, model)
  end
end
#:createop end
