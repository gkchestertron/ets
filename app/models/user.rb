class User < ActiveRecord::Base
    has_many :entries
    has_many :races, through: :entries
    has_secure_password
    before_validation :reset_session_token, on: :create
    validates :username, :session_token, :password_digest, presence: true

    def reset_session_token
        self.session_token = SecureRandom::urlsafe_base64(16)
    end
end
