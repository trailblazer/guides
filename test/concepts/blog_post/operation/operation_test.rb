require 'test_helper'
require_relative "../../../../app/models/user"
require_relative "../../../../app/models/blog_post"
require_relative "../../../../app/concepts/blog_post/operation/create"  
require_relative "../../../../app/concepts/user/operation/create"  

class BlogPostsOperationTest < MiniTest::Spec
  it "create" do 
    user = User::Create.({email: "user@email.com"})
    user.success?.must_be_equal true
    user = user["model"]

    result = BlogPost::Create.({title: "Title", body: "Body", author: user.email}, "current_user" => user)
    result.success?.must_be_equal true
  end
end