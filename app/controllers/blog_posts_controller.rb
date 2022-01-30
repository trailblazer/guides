#:new
class BlogPostsController < ApplicationController
  def new
    run BlogPost::Operation::Create::Present do |ctx|

      @form = ctx["contract.default"]
      render
    end
  end
#:new end

  #:create
  def create
    ctx = run BlogPost::Operation::Create do |ctx|
      return redirect_to blog_posts_path
    end

    @form = ctx["contract.default"]
    render :new
  end
  #:create end

  #:show
  def show
    run BlogPost::Operation::Show
    render cell(BlogPost::Cell::Show, result["model"]), layout: false
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
    run BlogPost::Operation::Update::Present
    render cell(BlogPost::Cell::Edit, @form), layout: false
  end
  #:edit end

  #:update
  def update
    run BlogPost::Operation::Update do |result|
      flash[:notice] = "#{result["model"].title} has been saved"
      return redirect_to blog_post_path(result["model"].id)
    end

    render cell(BlogPost::Cell::Edit, @form), layout: false
  end
  #:update end

  #:delete
  def destroy
    run BlogPost::Operation::Delete

    flash[:alert] = "Post deleted"
    redirect_to blog_posts_path
  end
  #:delete end
end
