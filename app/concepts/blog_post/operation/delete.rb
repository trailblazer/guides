#:delete
class BlogPost::Delete < Trailblazer::Operation
  step Model(BlogPost, :find_by)
  step :delete!

  def delete!(options, model:, **)
    model.destroy
  end
end
#:delete end
