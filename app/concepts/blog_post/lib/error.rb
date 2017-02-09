#:error
class BlogPost::Error 
  def self.call(options, *)
    false #raise error or return a Not found post
  end
end
#:error end