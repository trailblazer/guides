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

module Model
  BlogPost = Class.new(BlogPost)

  #:model
  class BlogPost::Create < Trailblazer::Operation
    step Policy::Guard( :authorize! )
    step Model( BlogPost, :new )
    step :persist!
    step :notify!

    def authorize!(options, current_user:, **)
      current_user.signed_in?
    end

    def persist!(options, params:, model:, **)
      model.update_attributes(params[:blog_post])
      model.save
    end

    def notify!(options, current_user:, model:, **)
      BlogPost::Notification.(current_user, model)
    end
  end
  #:model end
end

module Contract
  BlogPost = Class.new(BlogPost)

  #:contract
  require_relative "../contract/create"

  class BlogPost::Create < Trailblazer::Operation
    step Policy::Guard( :authorize! )
    step Model( BlogPost, :new )
    #:contract-build
    step Contract::Build( constant: BlogPost::Contract::Create )
    #:contract-build end
    #:contract-validate
    step Contract::Validate( key: :blog_post )
    #:contract-validate end
    step :persist!
    step :notify!

    def authorize!(options, current_user:, **)
      current_user.signed_in?
    end

    def persist!(options, params:, model:, **)
      model.save
    end

    def notify!(options, current_user:, model:, **)
      BlogPost::Notification.(current_user, model)
    end
  end
  #:contract end
end

module Persist
  BlogPost = Class.new(BlogPost)

  #:persist
  require_relative "../contract/create"

  class BlogPost::Create < Trailblazer::Operation
    step Policy::Guard( :authorize! )
    step Model( BlogPost, :new )
    step Contract::Build( constant: BlogPost::Contract::Create )
    step Contract::Validate( key: :blog_post )
    step Contract::Persist()
    step :notify!

    def authorize!(options, current_user:, **)
      current_user.signed_in?
    end

    def notify!(options, current_user:, model:, **)
      options["result.notify"] = BlogPost::Notification.(current_user, model)
    end
  end
  #:persist end
end
