class Contest < ApplicationRecord
    belongs_to :administrator
    has_many :voices

    validates :name, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :start_date, :end_date, range:true
    validates :administrator_id, :presence => true
end
