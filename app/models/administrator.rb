class Administrator

    include Mongoid::Document
    include ActiveModel::SecurePassword 
    include Mongoid::Attributes::Dynamic
    
    field :name, type: String
    field :last_name, type: String
    field :email, type: String
    field :password_digest, type: String
    field :created_at, type: DateTime

    has_secure_password
    has_many :contests, :dependent => :delete_all 

    validates :name, presence: true
    validates :last_name, presence: true
    validates :email, uniqueness: true, email: true
    validates :password, presence: true
    validates_confirmation_of :password, message: 'should match'
    
end
