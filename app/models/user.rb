class User
  include Mongoid::Document

  belongs_to :group, inverse_of: :members
  has_and_belongs_to_many :tags

  field :username, type: String
  validates :username, presence: true, uniqueness: true
end
