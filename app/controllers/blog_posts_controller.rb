#:new
class BlogPostsController < ApplicationController
  def new
    run BlogPost::Create::Present
    render cell(BlogPost::Cell::New, @form), layout: false
  end
#:new end

  #:create
  def create
    run BlogPost::Create do |result|
      return redirect_to blog_posts_path
    end

    render cell(BlogPost::Cell::New, @form), layout: false
  end
  #:create end

  #:show
  def show
    run BlogPost::Show
    render cell(BlogPost::Cell::Show, result["model"]), layout: false
  end
  #:show end

  #:index
  def index
    run BlogPost::Index
    render cell(BlogPost::Cell::Index, result["model"]), layout: false
  end
  #:index end

  #:edit
  def edit
    run BlogPost::Update::Present
    render cell(BlogPost::Cell::Edit, @form), layout: false
  end
  #:edit end

  #:update
  def update
    run BlogPost::Update do |result|
      flash[:notice] = "#{result["model"].title} has been saved"
      return redirect_to blog_post_path(result["model"].id)
    end

    render cell(BlogPost::Cell::Edit, @form), layout: false
  end
  #:update end

  #:delete
  def destroy
    run BlogPost::Delete

    flash[:alert] = "Post deleted"
    redirect_to blog_posts_path
  end
  #:delete end
end
