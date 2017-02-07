#:error_handler
class BlogPost::Error 
  def self.call(options, *)
    true #raise error or return a Not found post
  end
end
#:error_handler end