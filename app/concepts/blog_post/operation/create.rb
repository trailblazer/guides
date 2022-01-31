#:createop
# app/concepts/blog_post/operation/create.rb
module BlogPost::Operation
  class Create < Trailblazer::Operation
    # Only used to setup the form.
    class Present < Trailblazer::Operation
      step Model(BlogPost, :new)
      step Contract::Build(constant: BlogPost::Contract::Create)
    end

    #~present
    #:sub
    step Subprocess(Present) # Here, we actually run the {Present} operation.
    #:sub end
    step Contract::Validate(key: :blog_post)
    step Contract::Persist()
    step :notify!

    def notify!(ctx, model:, **)
      ctx["result.notify"] = Rails.logger.info("New blog post #{model.title}.")
    end
    #~present end
  end
end
#:createop end
