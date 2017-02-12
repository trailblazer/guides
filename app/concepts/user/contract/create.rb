require "reform"
require "reform/form/dry"

module User::Contract
  class Create < Reform::Form
    include Dry

    property :email
    property :firstname
    property :signed_in

    validation do
      required(:email).filled
    end
  end
end
