class User < ApplicationRecord
    has_many :projects
    attr_accessor :reset_password_token

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: {minimum: 5}
    validates :role, presence: true

    has_secure_password

    enum role: [:user, :manager, :admin]

    def reset_password_token!
        self.reset_password_token=generate_token
        save!(validate: false)
    end

    private

    def generate_token
        SecureRandom.hex(10)
    end

    
end
