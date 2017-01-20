module Op1
  #:fresh
  require "spec_helper"
  require_relative "../../../app/post/operation/create"

  RSpec.describe "Create" do
    it do
      Post::Create.()
    end
  end
  #:fresh end

  RSpec.describe "Create" do
    #:puts
    it do
      result = Post::Create.()
      puts result #=> #<Trailblazer::Operation::Result:0x9cd7dc4>
    end
    #:puts end
  end

  RSpec.describe "Create" do
    #:success
    it do
      result = Post::Create.()
      expect( result.success? ).to be true
    end
    #:success end
  end

end # Op1
module Op2 # Baby steps

  RSpec.describe "Create" do
    #:step
    it do
      result = Post::Create.()
      #=> Hello, Trailblazer!
      expect(result.success?).to be true #=> expected true, got false
    end
    #:step end
  end

end

module ReturnValue

  RSpec.describe "Create" do
    #:return-value
    it do
      result = Post::Create.()
      #=> Hello, Trailblazer!
      expect(result.success?).to be true
    end
    #:return-value end
  end

end

module MultipleSteps

  RSpec.describe "Create" do
    #:steps
    it do
      result = Post::Create.()
      #=> Hello, Trailblazer!
      #=> How are you?
      expect(result.success?).to be true
    end
    #:steps end
  end

end

module BreakingThings

  RSpec.describe "Create" do
    it do
      #:breaking
      result = Post::Create.()
      #=> Hello, Trailblazer!
      expect(result.failure?).to be true
      #:breaking end
    end
  end

end

module Success

  RSpec.describe "Create" do
    it do
      #:success
      result = Post::Create.()
      #=> Hello, Trailblazer!
      #=> How are you?
      expect(result.success?).to be true
      #:success end
    end
  end

end

module Input

  RSpec.describe "Create" do
    #:input
    it do
      result = Post::Create.( { healthy: "yes" } )
      #=> Hello, Trailblazer!
      #=> How are you?
      #=> Good to hear, have a nice day!
      expect(result.success?).to be true
    end
    #:input end

    #:input-false
    it do
      result = Post::Create.( { healthy: "i'm sad!" } )
      #=> Hello, Trailblazer!
      #=> How are you?
      expect(result.failure?).to be true
    end
    #:input-false end

    it do
      #:input-call
      result = Post::Create.( { healthy: "yes" } )
      #:input-call end
    end
  end

end
