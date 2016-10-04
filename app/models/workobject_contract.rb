class WorkobjectContract < ActiveRecord::Base
  attr_accessible :id, :wo_name, :wo_city, :address, :status, :co_id, :co_reg, :client, :c_number, :c_date, :staff, :job

  def self.search(search)
    if search
      where('wo_name LIKE ? OR address LIKE ? OR wo_city LIKE ? OR co_reg LIKE ? OR client LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end
end
