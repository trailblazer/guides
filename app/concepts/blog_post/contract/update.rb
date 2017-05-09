#:contract
module BlogPost::Contract
  class Update < Reform::Form
    include Dry

    #:property
    property :title
    property :body
    #:property end

    #:validation
    validation do
      required(:title).filled
      required(:body).filled(min_size?: 9)
    end
    #:validation end
  end
end
#:contract end
