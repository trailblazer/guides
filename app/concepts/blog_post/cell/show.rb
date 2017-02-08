module Post::Cell

  class Show < Trailblazer::Cell
    include ActionView::RecordIdentifier
    include ActionView::Helpers::FormOptionsHelper
    include Formular::RailsHelper
    include Formular::Helper
    
    property :title
    property :subtitle
    property :body

    def back
      link_to "Back to posts list", posts_path
    end

    def current_user
      return options[:context][:current_user]
    end

    def admin?
      current_user == nil ? false : current_user.email == "admin@email.com"
    end

    def owner?
      current_user == nil ? false : current_user.id == model.user_id
    end

    def admim_or_owner?
      admin? or owner?
    end

    def edit
      if admim_or_owner?
        link_to "Edit", edit_post_path(model.id)
      end
    end

    def delete
      if admim_or_owner?
        link_to "Delete", post_path(model.id), method: :delete, data: {confirm: 'Are you sure?'}
      end
    end

    def author
      if model.user_id != nil and current_user != nil and current_user.email == User.find(model.user_id).email
        link_to model.author, user_path(model.user_id)
      else
        return model.author
      end   
    end

    def time
      model.created_at
    end

    def status
      statuses = {
        "Approved" => "This post has been approved!",
        "Declined" => "Unfortunately this post has not been approved",
        "Pending" => "The status of this post is still pending",
      }

      statuses[model.status]
    end



  end
end
