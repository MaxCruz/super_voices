class Contest < ApplicationRecord
    belongs_to :administrator
    has_many :voices, :dependent => :delete_all

    validates :name, presence: true
    validates :url, presence: true, uniqueness: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :reward, presence: true
    validates :script, presence: true
    validates :start_date, :end_date, range:true
    validates :administrator_id, :presence => true
end
