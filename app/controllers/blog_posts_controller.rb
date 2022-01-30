#:new
class BlogPostsController < ApplicationController
  # The #run method comes from trailblazer-rails.
  #
  #
  def new
    run BlogPost::Operation::Create::Present do |ctx|

      @form = ctx["contract.default"]
      render
    end
  end
#:new end

  #:create
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
