class Shop
  include Mongoid::Document

  has_one :owner, class_name: "User"
  has_many :baristas, class_name: "User", inverse_of: :barista_shop
  has_many :patrons, class_name: "User", inverse_of: :patron_shop

end
