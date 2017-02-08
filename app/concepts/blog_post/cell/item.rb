module Post::Cell  
  class Item < Trailblazer::Cell

    def title
      if model == nil
        return "No posts"
      else
        link_to model.title, model
      end
    end

    def subtitle
      link_to model.subtitle, model unless model == nil
    end

    def author
      if model.user_id != nil and options["current_user"] != nil and options["current_user"].email == User.find(model.user_id).email
        link_to model.author, user_path(model.user_id)
      else
        return model.author
      end   
    end

    def time
      model.created_at
    end

    def current_user
      return options[:context][:current_user]
    end

    def admin?
      current_user == nil ? false : current_user.email == "admin@email.com"
    end

    def dec
      if params["owner"] == "true" or (params["status"] == nil and admin?)
        decorations = {
        "Pending" => "fa fa-clock-o",
        "Approved" => "fa fa-check-circle-o",
        "Declined" => "fa fa-times",
        }

        return decorations[model.status]
      end
    end
  end
end