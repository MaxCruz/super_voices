class Administrator < ApplicationRecord
    has_secure_password
    has_many :contests, :dependent => :delete_all 

    validates :name, presence: true
    validates :last_name, presence: true
    validates :email, uniqueness: true, email: true
    validates :password, presence: true

    validates_confirmation_of :password, message: 'should match'
    validates_presence_of :password_confirmation, if: :password_digest_changed?
end
