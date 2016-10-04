class StaffsRole < ActiveRecord::Base
  belongs_to :staff
  belongs_to :role
  attr_accessible :staff_id, :role_id
end
