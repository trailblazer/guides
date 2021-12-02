module User::Operation
  class Create < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build(constant: User::Contract::Create)
    step Contract::Validate(key: :user)
    step Contract::Persist()
  end
end
