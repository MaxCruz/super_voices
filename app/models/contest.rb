class Contest < ApplicationRecord
    belongs_to :administrator
    has_many :voices
end
