#:updateop
class BlogPost::Update < Trailblazer::Operation
  step Nested(BlogPost::Edit)
  step Contract::Validate()
  step Contract::Persist()
  step :notify!

  def notify!(options, current_user:, model:, **)
    options["result.notify"] = BlogPost::Notification.(current_user, model)
  end
end
#:updateop end
