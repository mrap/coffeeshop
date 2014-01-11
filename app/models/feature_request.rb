class FeatureRequest
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :requester, class_name: "User"
  has_many :votes, as: :votable

  field :description, type: String
  field :completed, type: Boolean, default: false

  validates_presence_of :requester
  validates :description, presence: true, length: { within: 15..600 }

  def votes_total
    Vote.total_for(self)
  end

end
