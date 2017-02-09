module Post::Cell  
  class Item < Trailblazer::Cell

    def title
      link_to model.title, model unless model == nil
    end

    def subtitle
      link_to model.subtitle, model unless model == nil
    end

    def author
       model.author
    end

    def time
      model.created_at
    end
    
  end
end