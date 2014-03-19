class User 
  include Neo4j::ActiveNode
  extend ::Devise::Models
  extend ::Devise::Orm::Neo4j::Hook
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  property :email, :index => :exact, :unique => true
  property :encrypted_password
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }

end