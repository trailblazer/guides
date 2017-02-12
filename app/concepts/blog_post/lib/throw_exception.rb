#:exception
require_relative "../../../controllers/application_controller"

class BlogPost::ThrowException 
  extend Uber::Callable
  def self.call(options, *)
    raise ApplicationController::NotAuthorizedError
  end
end 
#:exception end