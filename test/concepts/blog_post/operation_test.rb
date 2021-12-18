require 'test_helper'

# Don't you worry, we will switch to RSpec!
class BlogPostOperationTest < MiniTest::Spec
  it "creates {BlogPost} model with provided attributes" do
    result = BlogPost::Operation::Create.wtf?(
      params: {blog_post: {title: "Cool stuff!", body: "Great"}},
      current_user: "asdf",
      errors: {}
      )

    assert_equal true, result.success?

    model = result[:blog_post]
    assert_equal "Cool stuff!", model.title
    assert_equal "Great", model.body
    assert_equal "asdf", model.author

    assert_equal({}, result[:errors])
  end

  it "fails with invalid params" do
    result = BlogPost::Operation::Create.call(params: {}, errors: {} )

    assert_equal false, result.success?
    assert_equal({:title=>["Title is invalid"]}, result[:errors])
  end

  it "fails with invalid title and body" do
    result = BlogPost::Operation::Create.wtf?(params: {title: "", body: ""}, errors: {} )

    assert_equal false, result.success?
    assert_equal({:title=>["Title is invalid"]}, result[:errors])
  end
end
