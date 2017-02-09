require 'test_helper'
require_relative "../../../../app/models/user"
require_relative "../../../../app/models/blog_post"
require_relative "../../../../app/concepts/blog_post/operation/create"  
require_relative "../../../../app/concepts/user/operation/create"  

class BlogPostsOperationTest < MiniTest::Spec
  
  #:policy  
  it "not signed_in no post" do
    result = BlogPost::Create.({title: "Title", body: "Body"})
    resutl.failure?.must_be_equal true
    result["model"].must_be_equal nil
    result["result.policy.default"].must_be_equal false 
  end
  #:policy end

  #:validation
  it "wrong input" do 
    user = User::Create.({email: "user@email.com", signed_in: true})
    user.success?.must_be_equal true

    # all wrong
    result = BlogPost::Create.({title: "", body: "", author: "", user_id: ""}, "current_user" => user["model"])
    result.failure?.must_be_equal true
    result["result.contract.default"].errors.messages.inspect.must_equal ""

    # body is OK
    result = BlogPost::Create.({title: "", body: "Body more than 9", author: "", user_id: ""}, "current_user" => user["model"])
    result.failure?.must_be_equal true
    result["result.contract.default"].errors.messages.inspect.must_equal ""
  end
  #:validation end

  #:create
  it "successfully create" do 
    user = User::Create.({email: "user@email.com", signed_in: true})
    user.success?.must_be_equal true

    result = BlogPost::Create.({title: "Title", body: "Body more than 9", author: user["model"].email, user_id: user["model"].id}, "current_user" => user["model"])
    result.success?.must_be_equal true
    resutl["model"].title.must_equal "Title"
    ::BlogPost.all.size.must_equal 1
    # one notification has been sent to user
  end
  #:create end
end