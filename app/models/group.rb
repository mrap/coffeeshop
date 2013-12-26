class Group
  include Mongoid::Document

  has_many :members, class_name: "User", after_add: :member_added, after_remove: :member_removed
  has_many :tags
  has_many :messages
  validates :name, presence: true, uniqueness: true

  field :name, type: String
  field :members_count, type: Integer, default: 0

  scope :most_members, ->{ order_by(members_count: :desc) }

  def add_member(member)
    self.members << member
  end

  def remove_member(member)
    self.members.delete(member)
  end

  private

    def member_added(member)
      inc(members_count: 1)
    end

    def member_removed(member)
      inc(members_count: -1)
    end
end
