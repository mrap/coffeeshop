class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :author, class_name: "User"
  field :content

  validates_presence_of :author, :content

  default_scope ->{ order_by(created_at: :desc) }
end
