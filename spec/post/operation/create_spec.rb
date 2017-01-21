require 'spec_helper'
require_relative '../../../app/post/operation/create'

module Op1
  #:fresh
  RSpec.describe Op1::BlogPost::Create do
    it do
      BlogPost::Create.()
    end
  end
  #:fresh end

  RSpec.describe Op1::BlogPost::Create do
    #:puts
    it do
      result = BlogPost::Create.()
      puts result #=> #<Trailblazer::Operation::Result:0x9cd7dc4>
    end
    #:puts end
  end

  RSpec.describe Op1::BlogPost::Create do
    #:success
    it do
      result = BlogPost::Create.()
      expect(result.success?).to be_truthy
    end
    #:success end
  end
end # Op1

module Op2 # Baby steps
  RSpec.describe Op2::BlogPost::Create do
    #:step
    it do
      result = BlogPost::Create.()
      #=> Hello, Trailblazer!
      expect(result.success?).to be_truthy #=> expected true, got false
    end
    #:step end
  end
end

module ReturnValue
  RSpec.describe ReturnValue::BlogPost::Create do
    #:return-value
    it do
      result = BlogPost::Create.()
      #=> Hello, Trailblazer!
      expect(result.success?).to be_truthy
    end
    #:return-value end
  end
end

module MultipleSteps
  RSpec.describe MultipleSteps::BlogPost::Create do
    #:steps
    it do
      result = BlogPost::Create.()
      #=> Hello, Trailblazer!
      #=> How are you?
      expect(result.success?).to be_truthy
    end
    #:steps end
  end
end

module BreakingThings
  RSpec.describe BreakingThings::BlogPost::Create do
    it do
      #:breaking
      result = BlogPost::Create.()
      #=> Hello, Trailblazer!
      expect(result.failure?).to be_truthy
      #:breaking end
    end
  end
end

module Success
  RSpec.describe Success::BlogPost::Create do
    it do
      #:success
      result = BlogPost::Create.()
      #=> Hello, Trailblazer!
      #=> How are you?
      expect(result.success?).to be_truthy
      #:success end
    end
  end
end

module Input
  RSpec.describe Input::BlogPost::Create do
    #:input
    it do
      result = Post::Create.( { happy: "yes" } )
      #=> Hello, Trailblazer!
      #=> How are you?
      #=> Good to hear, have a nice day!
      expect(result.success?).to be_truthy
    end
    #:input end

    #:input-false
    it do
      result = BlogPost::Create.(happy: "i'm sad!")
      #=> Hello, Trailblazer!
      #=> How are you?
      expect(result.failure?).to be_truthy
    end
    #:input-false end

    it do
      #:input-call
      result = BlogPost::Create.(happy: "yes")
      #:input-call end
    end
  end
end

module Failure
  RSpec.describe Failure::BlogPost::Create do
    #:failure
    it do
      result = BlogPost::Create.(happy: false)
      #=> Hello, Trailblazer!
      #=> How are you?
      expect(result.failure?).to be_truthy
      expect(result["joke"]).to eq "Broken pencils are pointless."
    end
    #:failure end
  end
end
