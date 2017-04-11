class Voice < ApplicationRecord
	mount_uploader :source_url, VoiceUploader
	mount_uploader :destination_url, VoiceUploader
    belongs_to :contest

    validates :email, presence: true, email: true
    validates :name, presence: true
    validates :last_name, presence: true
    validates :contest_id, :presence => true
end
