#:model
User = Struct.new(:signed_in) do
  def signed_in?
    signed_in
  end
end
#:model end
