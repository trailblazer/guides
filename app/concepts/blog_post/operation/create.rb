#:createop
module BlogPost::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(BlogPost, :new)
      step Contract::Build(constant: BlogPost::Contract::Create)
    end

    #~present
    step Subprocess(Present)
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
