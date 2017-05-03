#:editop
class BlogPost::Edit < Trailblazer::Operation
  step Model(BlogPost, :find_by)
  # failure BlogPost::Error, fail_fast: true
  step Policy::Guard(:authorize!)
  step Contract::Build( constant: BlogPost::Contract::Edit )

  def authorize!(options, current_user:, model:, **)
    current_user == nil ? false : ((current_user.id == model.user_id) or (current_user.email == "admin@email.com"))
  end

end
#:editop end
