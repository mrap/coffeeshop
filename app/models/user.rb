class User
  include Mongoid::Document

  belongs_to :group, inverse_of: :members
  has_and_belongs_to_many :tags
  has_many :messages, inverse_of: :author

  field :username, type: String
  validates :username, presence: true, uniqueness: true
end
