module User::Contract
  class Create < Reform::Form
    include Dry

    property :email
    property :firstname
    property :signed_in, virtual: true

    validation do
      params do
       required(:email).filled
      end
    end
  end
end
