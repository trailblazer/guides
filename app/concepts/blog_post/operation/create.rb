require_relative "../lib/notification"

module Procedural
  BlogPost = Class.new(BlogPost)

  #:procedural
  require "trailblazer"

  class BlogPost::Create < Trailblazer::Operation
    step :do_everything!

    #:args
    def do_everything!(options, params:, current_user:, **)
      return unless current_user.signed_in?
    #:args end

      model = BlogPost.new
      model.update_attributes(params[:blog_post])

      if model.save
        BlogPost::Notification.(current_user, model)
      else
        return false
      end
    end
  end
  #:procedural end
end

module ProceduralSet
  BlogPost = Class.new(BlogPost)

  class BlogPost::Create < Trailblazer::Operation
    step :do_everything!

    #:procedural-set
    def do_everything!(options, params:, current_user:, **)
      return unless current_user.signed_in?

      model = BlogPost.new
      options["model"] = model # readable in steps and result.

      model.update_attributes(params[:blog_post])
      #~hide
      if model.save
        BlogPost::Notification.(current_user, model)
      else
        return false
      end
      #~hide end
    end
    #:procedural-set end
  end
end

module FirstSteps
  BlogPost = Class.new(BlogPost)

  #:firststeps
  class BlogPost::Create < Trailblazer::Operation
    step :authorize!
    step :model!
    step :persist!
    step :notify!

    def authorize!(options, current_user:, **)
      current_user.signed_in?
    end

    def model!(options, **)
      options["model"] = BlogPost.new
    end

    def persist!(options, params:, model:, **)
      model.update_attributes(params[:blog_post])
      model.save
    end

    def notify!(options, current_user:, model:, **)
      BlogPost::Notification.(current_user, model)
    end
  end
  #:firststeps end

end

module Policy
  BlogPost = Class.new(BlogPost)

  #:policy
  class BlogPost::Create < Trailblazer::Operation
    step Policy::Guard( :authorize! )
    step :model!
    step :persist!
    step :notify!

    def authorize!(options, current_user:, **)
      current_user.signed_in?
    end

    def model!(options, **)
      options["model"] = BlogPost.new
    end

    def persist!(options, params:, model:, **)
      model.update_attributes(params[:blog_post])
      model.save
    end

    def notify!(options, current_user:, model:, **)
      BlogPost::Notification.(current_user, model)
    end
  end
  #:policy end

end
