class User
  include Mongoid::Document

  belongs_to :group, inverse_of: :members
  has_and_belongs_to_many :tags
end
