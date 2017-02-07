#:appcontroller
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  class NotAuthorizedError < RuntimeError
  end
  
  rescue_from ApplicationController::NotAuthorizedError do
    flash[:alert] = "You are not authorized mate!"
    redirect_to posts_path
  end

  
  def render(cell_constant, model, options: {})
    super(
          html: cell(
                cell_constant,
                model,
                { layout: Blog::Cell::Layout,
                  context: {current_user: tyrant.current_user, flash: flash}
                  }.merge(options))
          )
  end


# private
#   def _run_options(options)
#     options.merge("current_user" => tyrant.current_user )
#   end
end
#:appcontroller end