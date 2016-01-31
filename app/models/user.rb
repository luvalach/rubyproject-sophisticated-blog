class User < ActiveRecord::Base
  before_save :assign_role

  resourcify
  rolify
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :blog

  attr_accessor :login

  validates :username,
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            }

  def assign_role
    self.add_role :user unless self.has_any_role?
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end

end
