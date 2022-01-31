#:contract
# app/concepts/blog_post/contract/create.rb
module BlogPost::Contract
  class Create < Reform::Form
    include Dry

    #:property
    property :title
    property :body
    #:property end

    #:validation
    validation do
      params do
        required(:title).filled
        required(:body).maybe(min_size?: 9)
      end
    end
    #:validation end
  end
end
#:contract end
