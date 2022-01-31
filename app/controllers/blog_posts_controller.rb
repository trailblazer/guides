#:new
# app/controllers/blog_posts_controller.rb
class BlogPostsController < ApplicationController
  #~doc
  # The #run method comes from trailblazer-rails.
  # https://trailblazer.to/2.1/docs/trailblazer.html#trailblazer-rails-run
  #
  # It runs the given operation and automatically passes `{params: params}`
  # into the operation invocation, as so
  #
  #    def new
  #      ctx = BlogPost::Operation::Create::Present.call(params: params)
  #
  # You can configure additional default variables going into the operation
  # by overriding {Controller#_run_options}:
  # https://trailblazer.to/2.1/docs/trailblazer.html#trailblazer-rails-run-controller-runtime-variables
  #
  # An alternative approach is to use endpoints - we will do this in a later chapter.
  #~doc end
  def new
    run BlogPost::Operation::Create::Present do |ctx|

      @form = ctx["contract.default"]
      render
    end
  end
#:new end

  #:create
  # app/controllers/blog_posts_controller.rb
  def create
    _ctx = run BlogPost::Operation::Create do |ctx|
      return redirect_to blog_posts_path
    end

    @form = _ctx["contract.default"]
    render :new
  end
  #:create end

  #:show
  def show
    run BlogPost::Operation::Show do |ctx|
      @model = ctx[:model]
      render
    end
  end
  #:show end

  #:index
  def index
    run BlogPost::Operation::Index do |ctx|
      @model = ctx[:model]
      @total = @model.count

      render
    end

  end
  #:index end

  #:edit
  def edit
    run BlogPost::Operation::Update::Present do |ctx|
      @form   = ctx["contract.default"]
      @title  = "Editing #{ctx[:model].title}"

      render
    end

  end
  #:edit end

  #:update
  def update
    _ctx = run BlogPost::Operation::Update do |ctx|
      flash[:notice] = "#{ctx[:model].title} has been saved"
      return redirect_to blog_post_path(ctx[:model].id)
    end

    @form   = _ctx["contract.default"] # FIXME: redundant to #create!
    @title  = "Editing #{_ctx[:model].title}"

    render :edit
  end
  #:update end

  #:delete
  def destroy
    run BlogPost::Operation::Delete

    flash[:notice] = "Post deleted"
    redirect_to blog_posts_path
  end
  #:delete end
end
