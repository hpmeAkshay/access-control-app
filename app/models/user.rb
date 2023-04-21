class User < ApplicationRecord
    has_many :projects
    
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: {minimum: 5}

    has_secure_password

    enum role: [:user, :manager, :admin]
end
