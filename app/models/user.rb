class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :role
  has_many :transactions
  has_many :stocks, through: :transactions
  
  validates :first_name, :last_name, :email, presence: true
  validates :password, presence: true, :if => :password
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

  def has_stock?(symbol)
    #checks if broker already has this stock in portfolio
     stock = Stock.search_db(symbol)
     return false unless stock
     stocks.where(id: stock.id).exists?
  end

end
