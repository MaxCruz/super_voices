class Voice < ApplicationRecord
    belongs_to :contest

    validates :contest_id, :presence => true
end
