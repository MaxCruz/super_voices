class Administrator < ApplicationRecord
    has_many :contests

    validates :name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true, email: true
    validates :password, presence: true, confirmation: true
end
