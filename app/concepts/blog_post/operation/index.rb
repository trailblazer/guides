#:indexop
module BlogPost::Operation
  class Index < Trailblazer::Operation
    step :model!

    def model!(ctx, **)
      ctx["model"] = ::BlogPost.all.reverse_order
    end
  end
end
#:indexop end
