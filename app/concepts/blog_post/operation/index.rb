#:indexop
class BlogPost::Index < Trailblazer::Operation
  step :model!

  def model!(options, *)
    options["model"] = ::BlogPost.all.reverse_order
  end
end
#:indexop end
