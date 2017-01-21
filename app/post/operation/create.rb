require 'trailblazer/operation'

module Op1
  #:op
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
        puts 'Hello, Trailblazer!'
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
        puts 'Hello, Trailblazer!'
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
        puts 'Hello, Trailblazer!'
        true
      end

      def how_are_you?(options, *)
        puts 'How are you?'
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
        puts 'Hello, Trailblazer!'
        # true
      end

      def how_are_you?(options, *)
        puts 'How are you?'
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
        puts 'Hello, Trailblazer!'
      end

      def how_are_you?(options, *)
        puts 'How are you?'
      end
    end
  end
  #:success end
end

module Input
  #:input
  module Post
    class Create < Trailblazer::Operation
      success :hello_world!
      step    :how_are_you?
      success :enjoy_your_day!

      def hello_world!(options, *)
        puts 'Hello, Trailblazer!'
      end

      def how_are_you?(options, params:, **)
        puts 'How are you?'

        params[:happy] == 'yes'
      end

      def enjoy_your_day!(options, *)
        puts 'Good to hear, have a nice day!'
      end
    end
  end
  #:input end
end

module Failure
  #:failure
  module Post
    class Create < Trailblazer::Operation
      success :hello_world!
      step    :how_are_you?
      success :enjoy_your_day!
      failure :tell_joke!

      def hello_world!(options, *)
        puts 'Hello, Trailblazer!'
      end

      def how_are_you?(options, params:, **)
        puts 'How are you?'

        params[:happy] == 'yes'
      end

      def enjoy_your_day!(options, *)
        puts 'Good to hear, have a nice day!'
      end

      def tell_joke!(options, *)
        options['joke'] = 'Broken pencils are pointless.'
      end
    end
  end
  #:failure end
end
