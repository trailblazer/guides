module BlogPost::Operation
   # @errors ||= {}

   #  if blog_post_params = params[:blog_post]
   #    if validate_for_create?(blog_post_params)

   #      @blog_post = BlogPost.new(current_user: @current_user, **blog_post_params)

   #      if @blog_post.save
   #        CreateMailer.new(blog_post: @blog_post).send_email

   #      end
   #    else
   #      @errors[:title] = ["Title is invalid"]
   #    end
   #  end
  class Create < Trailblazer::Operation
    class Validations < Dry::Validation::Contract
      params do
        required(:title).filled
        required(:body).filled
      end
    end

    step :extract_params, fail_fast: true
    step :validate_for_create?
    step :create_model
    step :notify

    def extract_params(ctx, params:, **)
      blog_post_params = params[:blog_post]

      ctx[:my_params] = blog_post_params
    end

    def validate_for_create?(ctx, my_params:, **)
      result = Validations.new.call(my_params)
      ctx[:errors] = result.errors

      result.success?
    end

    def create_model(ctx, my_params:, current_user:, **)
      ctx[:blog_post] = BlogPost.new(author: current_user, **my_params)
      ctx[:blog_post].save
    end

    def notify(ctx, blog_post:, **)
      CreateMailer.new(blog_post: blog_post).send_email
    end
  end
end
