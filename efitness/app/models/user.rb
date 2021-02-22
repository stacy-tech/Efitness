class User < ActiveRecord::Base
    has_secure_password
    has_many :efits
    validates :username, :email, presence: true, uniqueness: true
end
