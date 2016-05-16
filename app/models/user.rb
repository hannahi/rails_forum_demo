class User < ActiveRecord::Base
  has_many :messages
  has_many :ratings

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :email, :email_format => { :message => 'Invalid email specified!' }

  # Function that takes entered email and password and either permits or denies
  # user authentication. Compares hash of password against stored user
  # password_hash.
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  # before_save function that hashes specified password if one is given.
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
