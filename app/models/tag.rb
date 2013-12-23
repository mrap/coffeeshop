class Tag
  include Mongoid::Document

  belongs_to :group
  has_and_belongs_to_many :users
  field :name

  validates_uniqueness_of :name, scope: :group
end
