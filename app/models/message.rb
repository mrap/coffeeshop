class Message
  include Mongoid::Document
  
  belongs_to :group
  belongs_to :author, class_name: "User"
  field :content

  validates_presence_of :group, :author, :content
end
