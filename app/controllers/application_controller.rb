#:appcontroller
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  class NotAuthorizedError < RuntimeError
  end
  
  rescue_from ApplicationController::NotAuthorizedError do
    # not authorized flash message
    redirect_to posts_path
  end

  #:render
  def render(cell_constant, model, options: {})
    super(
          html: cell(
                cell_constant,
                model,
                { layout: BlogPost::Cell::Layout,
                  context: {current_user: current_user}
                  }.merge(options))
          )
  end
  #:render end

#:run_options
private
  def _run_options(options)
    options.merge("current_user" => tyrant.current_user )
  end
#:run_options end
end
#:appcontroller end