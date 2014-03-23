require 'orm_adapter'

class User 
  include Neo4j::ActiveNode
  extend ::Devise::Models
  extend ::Devise::Orm::Neo4j

  ##############
  ### Devise ###
  ##############
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  ##################
  ### Properties ###
  ##################

  property :email, :type => String, :index => :exact, :unique => true
  property :first_name, :type => String
  property :last_name, :type => String
  property :encrypted_password, :type => String
  property :created_at, :type => DateTime
  property :updated_at, :type => DateTime

  ## Rememberable
  property :remember_created_at, :type => DateTime, :index => :exact

  ## Recoverable
  property :reset_password_token,   :type => String, :index => :exact
  property :reset_password_sent_at, :type => DateTime

  ## Trackable
  property :sign_in_count, :type => Integer, :default => 0
  property :current_sign_in_at, :type => DateTime
  property :last_sign_in_at, :type => DateTime
  property :current_sign_in_ip, :type =>  String
  property :last_sign_in_ip, :type => String


  

  ###################
  ### Validations ###
  ###################

  validates :password, presence: true,
                       confirmation: true,
                       length: { :within => 6..40 }

  ########################
  ### Devise Overrides ###
  ########################

  def self.serialize_from_session(key, salt)
    record = self.find(key.first)
    record if record && record.authenticatable_salt == salt
  end     

  def self.find_first_by_auth_conditions(tainted_conditions, opts={})
    self.find(devise_parameter_filter.filter(tainted_conditions).merge(opts))
  end
end