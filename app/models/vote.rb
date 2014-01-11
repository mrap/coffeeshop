class Vote
  include Mongoid::Document
  belongs_to :votable, polymorphic: true
  belongs_to :voter, class_name: "User"

  field :is_positive?, type: Boolean, default: true

  validates_presence_of :votable
  validates :voter, presence: true, uniqueness: { scope: :votable }

  # Get the sum total of upvotes and downvotes for a given votable.
  def self.total_for(votable)
    total = 0
    votable.votes.each do |vote|
      vote.is_positive? ? total += 1 : total -= 1
    end
    return total
  end

  # Upvote / Downvote helper constructors
  def self.create_upvote(attributes = {})
    upvote = self.new_upvote(attributes)
    upvote.save
    return upvote
  end

  def self.create_downvote(attributes = {})
    downvote = self.new_downvote(attributes)
    downvote.save
    return downvote
  end

  def self.new_upvote(attributes = {})
    attributes[:is_positive?] = true
    self.new(attributes)
  end

  def self.new_downvote(attributes = {})
    attributes[:is_positive?] = false
    self.new(attributes)
  end

end
