module Post::Cell
  class Index < Trailblazer::Cell
    
    def current_user
      return options[:context][:current_user]
    end

    def admin?
      current_user == nil ? false : current_user.email == "admin@email.com"
    end

    def total
      return "No posts" if model.size == 0
    end
    
  end
end