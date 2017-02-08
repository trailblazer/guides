module Post::Cell
  class Index < Trailblazer::Cell
    
    def current_user
      return options[:context][:current_user]
    end

    def admin?
      current_user == nil ? false : current_user.email == "admin@email.com"
    end

    def caption
      if params["status"] != nil and admin?
        captions = {
        "Pending" => "Here are the pending posts:",
        "Approved" => "Here are the approved posts:",
        "Declined" => "Here are the declined posts:",
        }
        return captions[params["status"]]
      end
    end 

    def total
      if model.size == 0
        return "No posts"
      end
    end
  end
end