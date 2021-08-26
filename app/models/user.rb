class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :role

  validates :first_name, :last_name, :email, :password, presence: true

  before_save :default_values

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    self.role.name == 'Admin'
  end

  def broker?
    self.role.name == 'Broker'
  end

  def buyer?
    self.role.name == 'Buyer'
  end

  def default_values
    self.approved = 'true' unless self.role.name == 'Broker'
  end

  def active_for_authentication? 
    super && approved? 
  end 
  
  def inactive_message 
    approved? ? super : :not_approved
  end
end
