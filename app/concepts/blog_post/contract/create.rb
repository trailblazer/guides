#:contract
require "reform"
require "reform/form/dry"

module BlogPost::Contract
  class Create < Reform::Form
    include Dry

    #:property
    property :title
    property :body
    #:property end

    #:validation
    validation do
      required(:title).filled
      required(:body).filled?(gt?: 9)
    end
    #:validation end
  end
end
#:contract end
