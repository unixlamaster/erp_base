class Workobject < ActiveRecord::Base
  has_many :staffobjectjournals, dependent: :destroy
  attr_accessible :address, :city, :latitude, :longtitude, :name, :staff_id, :region, :complete, :status, :type_wo, :job, :client, :contract, :job_hands
  def fulladdr
    read_attribute(:name)+", "+read_attribute(:city)+", "+read_attribute(:address)
  end

  def self.search(search)
    if search
      where('name LIKE ? OR address LIKE ? OR city LIKE ? OR region LIKE ? OR lname LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end
end
