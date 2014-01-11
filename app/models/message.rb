class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  MAX_LENGTH = 300

  belongs_to :author, class_name: "User"
  field :content

  validates_presence_of :author, :content
  validates_length_of :content, maximum: MAX_LENGTH

  default_scope ->{ order_by(created_at: :desc) }
end
