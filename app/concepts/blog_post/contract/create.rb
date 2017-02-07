#:contract
require "reform"
require "reform/form/dry"

module BlogPost::Contract
  class Create < Reform::Form
    include Dry

    #:property
    property :title
    property :body
    property :author
    property :user_id
    #:property end

    #:validation
    validation do
      required(:title).filled
      required(:author).filled
      required(:user_id).filled
      required(:body).maybe(min_size?: 9)
    end
    #:validation end
  end
end
#:contract end
