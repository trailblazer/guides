#:postcontroller
class BlogPostsController < ApplicationController
  #:new
  def new
    run BlogPost::Create::Present
    render BlogPost::Cell::New, @form
  end
  #:new end

  #:create
  def create
    run BlogPost::Create do |result|
      flash[:notice] = "#{result["model"].title} has been created"
      return redirect_to "/posts"
    end
    render BlogPost::Cell::New, @form
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
    render BlogPost::Cell::Index, result["model"]
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
#:postcontroller end
