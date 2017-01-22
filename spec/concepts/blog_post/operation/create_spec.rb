module Procedural
  #:procedural
  require "spec_helper"
  require_relative "../../../../app/models/user"
  require_relative "../../../../app/models/blog_post"
  require_relative "../../../../app/concepts/blog_post/operation/create"

  RSpec.describe BlogPost::Create do
    let (:anonymous) { User.new(false) }
    let (:signed_in) { User.new(true) }
    let (:pass_params) { { blog_post: { title: "Puns: Ode to Joy" } } }

    it "fails with anonymous" do
      result = BlogPost::Create.(pass_params, "current_user" => anonymous)

      expect(result).to be_failure
      expect(BlogPost.last).to be_nil
    end
  #:procedural end

    it "works with known user" do
      result = BlogPost::Create.(pass_params, "current_user" => signed_in)

      expect(result).to be_success
      expect(BlogPost.last).to be_persisted
      expect(BlogPost.last.title).to eq("Puns: Ode to Joy")
    end
  end
end
