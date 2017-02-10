module BlogPost::Cell

  class Show < Trailblazer::Cell
    property :title
    property :body
    property :author


    def current_user
      return options[:context][:current_user]
    end

    def time
      model.created_at
    end

    def admin?
      current_user == nil ? false : current_user.email == "admin@email.com"
    end

    def owner?
      current_user == nil ? false : current_user.id == model.user_id
    end

    def edit
      link_to "Edit", edit_post_path(model.id) if admin? or owner?
    end

    def delete
      link_to "Delete", post_path(model.id), method: :delete, data: {confirm: 'Are you sure?'} if admin? or owner?
    end

    def back
      link_to "Back to posts list", posts_path
    end
    
  end
end
