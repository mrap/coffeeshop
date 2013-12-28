class UnregisteredUser < User
  field :token, type: String
  validates :token, presence: true, uniqueness: true
  before_validation :refresh_token

  def refresh_token
    self.token = UnregisteredUser.unique_token
  end

  private

    def self.unique_token
      loop do
        new_token = SecureRandom.hex(8)
        return new_token unless UnregisteredUser.where(token: new_token).exists?
      end
    end
end
