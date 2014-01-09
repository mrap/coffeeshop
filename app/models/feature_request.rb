class FeatureRequest
  include Mongoid::Document

  belongs_to :requester, class_name: "User"
  field :description, type: String

  validates_presence_of :requester
  validates :description, presence: true, length: { within: 15..600 }

end
