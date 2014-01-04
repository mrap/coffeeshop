class Group
  include Mongoid::Document
  include Mongoid::Search

  has_many :members, class_name: "User", before_add: :adding_member, before_remove: :removing_member
  has_many :tags
  has_many :messages
  validates :name, presence: true, uniqueness: true

  field :name, type: String
  field :members_count, type: Integer, default: 0

  search_in :name

  scope :most_members, ->{ order_by(members_count: :desc) }

  def add_member(member)
    member.group.remove_member(member) if member.group && member.group != self
    self.members << member
  end

  def remove_member(member)
    self.members.delete(member)
  end

  private

    def adding_member(member)
      inc(members_count: 1) unless self.members.include? member
    end

    def removing_member(member)
      inc(members_count: -1) if self.members.include? member
    end
end
