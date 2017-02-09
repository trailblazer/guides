require 'test_helper'
require_relative "../../../../app/models/user"
require_relative "../../../../app/models/blog_post"
require_relative "../../../../app/concepts/blog_post/operation/create"  
require_relative "../../../../app/concepts/blog_post/operation/show"  
require_relative "../../../../app/concepts/user/operation/create"  

class BlogPostsOperationTest < MiniTest::Spec
  
  #:policy  
  it "not signed_in no post" do
    result = BlogPost::Create.({title: "Title", body: "Body"}, "current_user" => nil)
    result.failure?.must_equal true
    result["model"].must_equal nil
    result["result.policy.default"].success?.must_equal false

    user = User::Create.({email: "user@email.com", signed_in: false})
    user.success?.must_equal true

    result = BlogPost::Create.({title: "Title", body: "Body"}, "current_user" => user["model"])
    result.failure?.must_equal true
    result["model"].must_equal nil
    result["result.policy.default"].success?.must_equal false
  end
  #:policy end

  #:validation
  it "wrong input" do 
    user = User::Create.({email: "user@email.com", signed_in: true})
    user.success?.must_equal true

    # all wrong
    result = BlogPost::Create.({}, "current_user" => user["model"])
    result.failure?.must_equal true
    result["result.contract.default"].errors.messages.inspect.must_equal "{:title=>[\"is missing\"], :author=>[\"is missing\"], :user_id=>[\"is missing\"], :body=>[\"is missing\", \"size cannot be less than 9\"]}"

    # body is OK
    result = BlogPost::Create.({title: "", body: "Body more than 9", author: "", user_id: ""}, "current_user" => user["model"])
    result.failure?.must_equal true
    result["result.contract.default"].errors.messages.inspect.must_equal "{:title=>[\"must be filled\"], :author=>[\"must be filled\"], :user_id=>[\"must be filled\"]}"
  end
  #:validation end

  #:create
  it "successfully create" do 
    user = User::Create.({email: "user@email.com", signed_in: true})
    user.success?.must_equal true

    result = BlogPost::Create.({title: "Title", body: "Body more than 9", author: user["model"].email, user_id: user["model"].id}, "current_user" => user["model"])
    result.success?.must_equal true
    result["model"].title.must_equal "Title"
    ::BlogPost.all.size.must_equal 1
    # one notification has been sent to user
  end
  #:create end

  #:show
  it "show post" do
    user = User::Create.({email: "user@email.com", signed_in: true})
    user.success?.must_equal true

    post = BlogPost::Create.({title: "Title", body: "Body more than 9", author: user["model"].email, user_id: user["model"].id}, "current_user" => user["model"])

    result = BlogPost::Show.({id: post["model"].id})
    result.success?.must_equal true
  end
  #:show end

  #:wronguser
  it "only owner or admin update post" do 
    owner = User::Create.({email: "owner@email.com", signed_in: true})
    owner.success?.must_equal true

    user = User::Create.({email: "user@email.com", signed_in: true})
    user.success?.must_equal true

    admin = User::Create.({email: "admin@email.com", signed_in: true})
    admin.success?.must_equal true

    result = BlogPost::Create.({title: "Title", body: "Body more than 9", author: owner["model"].email, user_id: owner["model"].id}, "current_user" => owner["model"])
    result.success?.must_equal true
    result["model"].title.must_equal "Title"

    

  end
  #:wronguser end

  #:update
  it "successfully update" do 
    
  end
  #:update end


end