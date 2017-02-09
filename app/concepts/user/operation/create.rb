require 'trailblazer/operation'
require_relative "../contract/create"

class User::Create < Trailblazer::Operation
  step Model(User, :new)
  step Contract::Build(constant: User::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()
end