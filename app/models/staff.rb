class Staff < ActiveRecord::Base
  ROLES = %w[admin user finansist guest]
  has_many :tasks
  has_many :staffs_roles
  has_many :roles, :through => :staffs_roles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable and :registerable
  devise :database_authenticatable, :recoverable,
          :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :password, :password_confirmation, :remember_me,
                  :birthday, :fname, :lname, :mname, :passport, :position,
                  :skill, :login, :email, :phone1, :phone2, :roles, :status
#  validates :birthday, presence: true
  validates :fname, presence: true
  validates :lname, presence: true
#  validates :mname, presence: true
#  validates :passport, presence: true
#  validates :position, presence: true
#  validates :skill, presence: true

  validates_presence_of :login
  validates_uniqueness_of :login, :email, :case_sensitive => false

  def self.search(search)
    if search
     where('fname LIKE ? OR lname LIKE ? OR mname LIKE ?  OR position LIKE ?  OR birthday like ? or login LIKE ? or email LIKE ? OR phone1 LIKE ? or status LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%")
      else
     scoped
    end
   end


  def fullname
     res="#{read_attribute(:lname)} #{read_attribute(:fname)} #{read_attribute(:mname)}"
     res+=", "+read_attribute(:position) unless read_attribute(:position).nil?
     res
  end

  def f_l_name
     "#{read_attribute(:fname)} #{read_attribute(:lname)}"
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
  ROLES.reject do |r|
  ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
  end
  end

  def is?(role)
    roles.include?(role.to_s)
  end
end



