class UnregisteredUser < User
  # UnregisteredUser does not need a email or password
  reset_callbacks :validate

  field :token, type: String
  validates :username, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true
  before_validation :set_random_username, :refresh_token

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

    def set_random_username
      loop do
        new_username = Bazaar.object
        self.username = new_username and break unless User.where(username: new_username).exists?
      end
    end
end
