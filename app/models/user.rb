class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :role, optional: true

  validates :first_name, :last_name, :email, :password, presence: true

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
end
