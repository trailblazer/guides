require "test_helper"

# Don't you worry, we will switch to RSpec! #not
class BlogPostOperationTest < MiniTest::Spec
  it "creates {BlogPost} model with provided attributes" do
    current_user = User.create(email: "you@trb.to")

    result = BlogPost::Operation::Create.wtf?(
      params: {blog_post: {title: "Cool stuff!", body: "Great"}},
      current_user: current_user
    )

    assert_equal true, result.success?

    model = result[:blog_post]
    assert_equal "Cool stuff!", model.title
    assert_equal "Great", model.body
    assert_equal current_user.id, model.user_id

    assert_equal({}, result["result.contract.default"].errors.to_h)

    # assert notification
    model = result[:notification]
    assert_equal true, model.persisted?
    assert_equal current_user.id, model.user_id
    assert_equal "blog_post_created", model.category
    assert_equal result[:blog_post].id, model.record_id
  end

  it "fails with invalid params" do
    result = BlogPost::Operation::Create.wtf?(params: {})

    assert_equal false, result.success?
    assert_nil(result["result.contract.default"])
  end

  it "fails with invalid title and body" do
    result = BlogPost::Operation::Create.wtf?(params: {blog_post: {title: "", body: ""}} )

    assert_equal false, result.success?
    assert_equal({:title=>["must be filled"], :body=>["must be filled"]}, result["result.contract.default"].errors.to_h)
  end
end
