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
    render BlogPost::Cell::Show, result["model"]
  end
  #:show end

  #:index
  def index
    run BlogPost::Index
    render cell(BlogPost::Cell::Index, result["model"]), layout: false
  end
  #:index end

  #:edit-update
  def edit
    run BlogPost::Edit
    render BlogPost::Cell::Edit, result["contract.default"]
  end

  def update
    run BlogPost::Update do |result|
      flash[:notice] = "#{result["model"].title} has been saved"
      return redirect_to "/posts/#{result["model"].id}"
    end

    render BlogPost::Cell::Edit, result["contract.default"]
  end
  #:edit-update end

  #:delete
  def destroy
    run BlogPost::Delete do
      flash[:alert] = "Post deleted"
      return redirect_to "/posts"
    end

    render BlogPost::Cell::Edit, result["contract.default"]
  end
  #:delete end
end
