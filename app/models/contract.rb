class Contract < ActiveRecord::Base
  belongs_to :staff
  attr_accessible :id, :c_date, :c_number, :client, :name, :region, :staff_id
 def self.search(search)
    if search
      where('name LIKE ? OR region LIKE ? OR clients LIKE ? ',"%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end
end
