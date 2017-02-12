require 'trailblazer/operation'

#:updateop
require_relative "../lib/notification"
require_relative "../operation/edit"

class BlogPost::Update < Trailblazer::Operation
  step Nested(BlogPost::Edit)
  step Contract::Validate(key: :blog_post)
  step Contract::Persist()
  step :notify!

  def notify!(options, current_user:, model:, **)
    options["result.notify"] = BlogPost::Notification.(current_user, model)
  end
end
#:updateop end
