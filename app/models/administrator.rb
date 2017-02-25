class Administrator < ApplicationRecord
    has_many :contests

    validates :name, presence: true
    validates :last_name, presence: true
    validates :email, uniqueness: true, email: true
    validates :password, presence: true

    validates_confirmation_of :password, message: 'should match confirmation'
    validates_presence_of :password_confirmation, if: :password_changed?
end
