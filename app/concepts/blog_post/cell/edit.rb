module Post::Cell
  class Edit < New

    def back
      link_to "Back", post_path(model.id)
    end 

    def delete
      link_to "Delete Post", post_path(model.id), method: :delete
    end

    def user_name_admin
      if model.user_id == nil
        name = model.author 
      else
        user = User.find(model.user_id)
        user.firstname.blank? ? (name = user.email) : (name = user.firstname)
      end

      return name = name + " (edited by Admin)"
    end

  end
end
