module Op1

  #:op
  require "trailblazer/operation"

  module Post
    class Create < Trailblazer::Operation
    end
  end
  #:op end
  end
module Op2

  #:step
  module Post
    class Create < Trailblazer::Operation
      step :hello_world!

      def hello_world!(options, *)
        puts "Hello, Trailblazer!"
      end
    end
  end
  #:step end

end

module ReturnValue

  #:return-value
  module Post
    class Create < Trailblazer::Operation
      step :hello_world!

      def hello_world!(options, *)
        puts "Hello, Trailblazer!"
        true
      end
    end
  end
  #:return-value end

end

module MultipleSteps

  #:steps
  module Post
    class Create < Trailblazer::Operation
      step :hello_world!
      step :how_are_you?

      def hello_world!(options, *)
        puts "Hello, Trailblazer!"
        true
      end

      def how_are_you?(options, *)
        puts "How are you?"
        true
      end
    end
  end
  #:steps end

end

module BreakingThings

  #:breaking
  module Post
    class Create < Trailblazer::Operation
      step :hello_world!
      step :how_are_you?

      def hello_world!(options, *)
        puts "Hello, Trailblazer!"
        # true
      end

      def how_are_you?(options, *)
        puts "How are you?"
        true
      end
    end
  end
  #:breaking end

end

module Success

  #:success
  module Post
    class Create < Trailblazer::Operation
      success :hello_world!
      success :how_are_you?

      def hello_world!(options, *)
        puts "Hello, Trailblazer!"
      end

      def how_are_you?(options, *)
        puts "How are you?"
      end
    end
  end
  #:success end

end
