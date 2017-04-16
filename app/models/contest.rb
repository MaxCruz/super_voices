class Contest

    include Mongoid::Document
    include Mongoid::Attributes::Dynamic
    mount_uploader :image, PictureUploader
  
    field :name, type: String
    field :image, type: String
    field :url, type: String
    field :start_date, type: Date 
    field :end_date, type: Date
    field :reward, type: Integer
    field :created_at, type: DateTime
    field :script, type: String
    field :recomendations, type: String 

    belongs_to :administrator
    has_many :voices, :dependent => :destroy

    validates :name, presence: true
    validates :url, presence: true, uniqueness: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :reward, presence: true
    validates :script, presence: true
    validates :start_date, :end_date, range:true
    validates :administrator_id, :presence => true

end
