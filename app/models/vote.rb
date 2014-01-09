class Vote
  include Mongoid::Document
  belongs_to :votable, polymorphic: true
  belongs_to :voter, class_name: "User"

  field :is_positive?, type: Boolean, default: true

  validates_presence_of :votable
  validates :voter, presence: true, uniqueness: { scope: :votable }

  # Upvote / Downvote helper constructors
  def self.create_upvote(attributes = {})
    self.create!(attributes)
  end

  def self.create_downvote(attributes = {})
    attributes[:is_positive?] = false
    self.create!(attributes)
  end

  # Get the sum total of upvotes and downvotes for a given votable.
  def self.total_for(votable)
    total = 0
    votable.votes.each do |vote|
      vote.is_positive? ? total += 1 : total -= 1
    end
    return total
  end

end
