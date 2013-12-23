class User
  include Mongoid::Document

  belongs_to :group, inverse_of: :members
end
