module Procedural
  #:procedural
  require "spec_helper"
  require_relative "../../../app/models/user"
  require_relative "../../../app/models/blog_post"
  require_relative "../../../app/concepts/blog_post/operation/create"

  RSpec.describe BlogPost::Create do
    let (:pass_params) { { blog_post: { title: "More bad jokes!" } } }

    it do
      result = BlogPost::Create.(pass_params, "current_user" => User.new)

      expect(result).to be_failure
    end
  end
  #:procedural end
end
