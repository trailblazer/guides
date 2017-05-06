#item
module BlogPost::Cell
  class Item < Trailblazer::Cell
    def title
      link_to model.title, model unless model == nil
    end

    property :body

    def created_at
      model.created_at.strftime("%d %B %Y")
    end
  end
end
#item end
