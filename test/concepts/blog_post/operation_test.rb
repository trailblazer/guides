require 'test_helper'

class BlogPostsOperationTest < MiniTest::Spec

  #:policy
  it "not signed_in no post" do
    skip
    result = BlogPost::Operation::Create.({title: "Title", body: "Body"}, "current_user" => nil)
    result.failure?.must_equal true
    result["model"].must_equal nil
    result["result.policy.default"].success?.must_equal false

    user = User::Operation::Create.(params: {email: "user@email.com", signed_in: false})
    user.success?.must_equal true

    result = BlogPost::Operation::Create.({title: "Title", body: "Body"}, "current_user" => user["model"])
    result.failure?.must_equal true
    result["model"].must_equal nil
    result["result.policy.default"].success?.must_equal false
  end
  #:policy end

  #:validation
  it "wrong input" do
    result = User::Operation::Create.(params: {user: {email: "user@email.com", signed_in: true}})
    result.success?.must_equal true

    user = result[:model]

    # all wrong
    result = BlogPost::Operation::Create.wtf?(params: {blog_post: {}}, current_user: user)
    result.failure?.must_equal true
    result["contract.default"].errors.messages.inspect.must_equal "{:title=>[\"must be filled\"]}"

    # body is OK
    result = BlogPost::Operation::Create.(params: {title: "", body: "Body more than 9", author: "", user_id: ""}, current_user: user)
    result.failure?.must_equal true
    result["contract.default"].errors.messages.inspect.must_equal "{:title=>[\"must be filled\"], :author=>[\"must be filled\"], :user_id=>[\"must be filled\"]}"
  end
  #:validation end

  #:create
  it "successfully create" do
    result = User::Operation::Create.wtf?(params: {user: {email: "user@email.com"}})
    result.success?.must_equal true
    user = result[:model]

    result = BlogPost::Operation::Create.wtf?(params: {blog_post: {title: "Title", body: "Body more than 9", author: user.email, user_id: user.id}}, current_user: user)
    result.success?.must_equal true
    result[:model].title.must_equal "Title"
    ::BlogPost.all.size.must_equal 1
    # one notification has been sent to user
  end
  #:create end

  #:not_found
  it "post not found" do
    user = User::Operation::Create.(params: {email: "user@email.com", signed_in: true})
    user.success?.must_equal true

    post = BlogPost::Operation::Create.({title: "Title", body: "Body more than 9", author: user["model"].email, user_id: user["model"].id}, "current_user" => user["model"])
    post.success?.must_equal true

    result = BlogPost::Operation::Show.({id: 100})
    result.failure?.must_equal true
    result["model"].title.must_equal "Post Not Found!"
  end
  #:not_found end

  #:show
  it "show post" do
    user = User::Operation::Create.(params: {email: "user@email.com", signed_in: true})
    user.success?.must_equal true

    post = BlogPost::Operation::Create.({title: "Title", body: "Body more than 9", author: user["model"].email, user_id: user["model"].id}, "current_user" => user["model"])
    post.success?.must_equal true

    result = BlogPost::Operation::Show.({id: post["model"].id})
    result.success?.must_equal true
  end
  #:show end

  #:update
  it "only owner or admin update post" do
    owner = User::Operation::Create.(params: {email: "owner@email.com", signed_in: true})
    owner.success?.must_equal true

    user = User::Operation::Create.(params: {email: "user@email.com", signed_in: true})
    user.success?.must_equal true

    admin = User::Operation::Create.(params: {email: "admin@email.com", signed_in: true})
    admin.success?.must_equal true

    post = BlogPost::Operation::Create.({title: "Title", body: "Body more than 9", author: owner["model"].email, user_id: owner["model"].id}, "current_user" => owner["model"])
    post.success?.must_equal true
    post["model"].title.must_equal "Title"

    #post not found
    result = BlogPost::Operation::Update.({id: 100}, "current_user" => nil)
    result.failure?.must_equal true
    result["model"].title.must_equal "Post Not Found!"
    BlogPost.find(post["model"].id).title.must_equal "Title"

    #no user
    assert_raises ApplicationController::NotAuthorizedError do
      BlogPost::Operation::Update.(
        {id: post["model"].id,
        title: "NewTitle"},
        "current_user" => nil)
    end

    #wrong user
    assert_raises ApplicationController::NotAuthorizedError do
      BlogPost::Operation::Update.(
        {id: post["model"].id,
        title: "NewTitle"},
        "current_user" => user["model"])
    end

    result = BlogPost::Operation::Update.({id: post["model"].id, title: "NewTitle"}, "current_user" => owner["model"])
    result.success?.must_equal true
    result["model"].title.must_equal "NewTitle"
    BlogPost.find(post["model"].id).title.must_equal "NewTitle"

    result = BlogPost::Operation::Update.({id: post["model"].id, title: "AdminTitle"}, "current_user" => admin["model"])
    result.success?.must_equal true
    result["model"].title.must_equal "AdminTitle"
    BlogPost.find(post["model"].id).title.must_equal "AdminTitle"
  end
  #:update end

  #:delete
  it "only owner or admin can delete BlogPost" do
    owner = User::Operation::Create.(params: {email: "owner@email.com", signed_in: true})
    owner.success?.must_equal true

    user = User::Operation::Create.(params: {email: "user@email.com", signed_in: true})
    user.success?.must_equal true

    admin = User::Operation::Create.(params: {email: "admin@email.com", signed_in: true})
    admin.success?.must_equal true

    post = BlogPost::Operation::Create.({title: "Title", body: "Body more than 9", author: owner["model"].email, user_id: owner["model"].id}, "current_user" => owner["model"])
    post.success?.must_equal true
    post["model"].title.must_equal "Title"

    #post not found
    result = BlogPost::Operation::Delete.({id: 100}, "current_user" => nil)
    result.failure?.must_equal true
    result["model"].title.must_equal "Post Not Found!"

    #no user
    assert_raises ApplicationController::NotAuthorizedError do
      BlogPost::Operation::Delete.(
        {id: post["model"].id},
        "current_user" => nil)
    end

    #wrong user
    assert_raises ApplicationController::NotAuthorizedError do
      BlogPost::Operation::Delete.(
        {id: post["model"].id},
        "current_user" => user["model"])
    end

    result = BlogPost::Operation::Delete.({id: post["model"].id}, "current_user" => owner["model"])
    result.success?.must_equal true
    BlogPost.where("id like ?", post["model"].id).size.must_equal 0
    # 1 notification has been sent

    owner = User::Operation::Create.(params: {email: "owner@email.com", signed_in: true})
    owner.success?.must_equal true

    admin = User::Operation::Create.(params: {email: "admin@email.com", signed_in: true})
    admin.success?.must_equal true

    post = BlogPost::Operation::Create.({title: "Title", body: "Body more than 9", author: owner["model"].email, user_id: owner["model"].id}, "current_user" => owner["model"])
    post.success?.must_equal true
    post["model"].title.must_equal "Title"

    result = BlogPost::Operation::Delete.({id: post["model"].id}, "current_user" => admin["model"])
    result.success?.must_equal true
    BlogPost.where("id like ?", post["model"].id).size.must_equal 0
    # 1 notification has been sent
  end
  #:delete end

end
