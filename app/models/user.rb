class User < ActiveRecord::Base
	has_many :user_roles
	has_many :roles, through: :user_roles
  has_many :todos

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    def admin?
    	admin_role = Role.first
    	self.roles.include?(admin_role)
    end

end