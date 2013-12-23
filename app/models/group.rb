class Group
  include Mongoid::Document

  field :name, type: String
  has_many :members, class_name: "User"

  def add_member(member)
    self.members << member
  end
  
  def remove_member(member)
    self.members.delete(member)
  end
end
