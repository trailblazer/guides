#:error
class BlogPost::Error 
  extend Uber::Callable
  def self.call(options, *)
    options["model"] = BlogPost.new(title: "Post Not Found!")
  end
end
#:error end