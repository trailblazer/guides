module Procedural

  #:procedural
  require "trailblazer"

  class BlogPost::Create < Trailblazer::Operation
    step :do_everything!

    def do_everything!(options, params:, current_user:, **)
      return unless current_user.signed_in?

      model = BlogPost.new
      model.update_attributes(params[:blog_post])

      if model.save
        Notification.(current_user, model)
      else
        return false
      end
    end
  end
  #:procedural end
end

