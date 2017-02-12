#:contract
require "reform"
require "reform/form/dry"

module BlogPost::Contract
  class Edit < Reform::Form
    include Dry

    #:property
    property :title
    property :body
    property :author
    #:property end

    #:validation
    validation do
      required(:title).filled
      required(:author).filled
      required(:body).filled(min_size?: 9)
    end
    #:validation end
  end
end
#:contract end
