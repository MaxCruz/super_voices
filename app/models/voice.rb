class Voice

    include Mongoid::Document
	include Mongoid::Attributes::Dynamic
    mount_uploader :source_url, VoiceUploader

    field :email, type: String
    field :name, type: String
    field :last_name, type: String
    field :message, type: String
    field :source, type: String
    field :created_at, type: DateTime

    belongs_to :contest 

    validates :email, presence: true, email: true
    validates :name, presence: true
    validates :last_name, presence: true
    validates :contest_id, :presence => true

end
