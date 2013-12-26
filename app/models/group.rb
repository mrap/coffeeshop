class Group
  include Mongoid::Document

  has_many :members, class_name: "User"
  has_many :tags
  validates :name, presence: true, uniqueness: true

  field :name, type: String
  field :members_count, type: Integer, default: 0

  scope :most_members, ->{ order_by(members_count: :desc) }

  def add_member(member)
    self.members << member
    update_members_count
  end

  def remove_member(member)
    self.members.delete(member)
    update_members_count
  end

  private

    def update_members_count
      self.members_count = self.members.count
    end
end
