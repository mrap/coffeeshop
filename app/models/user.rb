class User
  include Mongoid::Document

  has_many :messages, inverse_of: :author, dependent: :destroy
  has_many :feature_requests, inverse_of: :requester, dependent: :destroy
  has_many :votes, inverse_of: :voter, dependent: :destroy

  field :username, type: String
  validates :username, presence: true, uniqueness: true
  after_initialize :set_random_username

  # Devise
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  private

    def set_random_username
      self.username ||= unique_random_username
    end

    def unique_random_username
      loop do
        new_username = Bazaar.object
        return new_username unless User.where(username: new_username).exists?
      end
    end
end
