module Post::Cell
  class Edit < New

    def back
      link_to "Back", post_path(model.id)
    end 

    def delete
      link_to "Delete Post", post_path(model.id), method: :delete
    end
  end
end
