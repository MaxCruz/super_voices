class Contest < ApplicationRecord
    belongs_to :administrator
    has_many :voices

    validates :administrator_id, :presence => true
end
