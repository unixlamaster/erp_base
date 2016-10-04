class Role < ActiveRecord::Base
  has_many :staffs_roles
  has_many :staffs, :through => :staffs_roles
  attr_accessible :name
end
