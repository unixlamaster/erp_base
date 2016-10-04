class FinanceWoStaff < ActiveRecord::Base
  self.table_name = "finances_wo_staff"
  attr_accessible :id, :wo_full, :staff_full, :cost_type, :fin_item, :staff_id, :staff_item, :wo_id, :summa, :d1, :d2, :remark, :invoice

  def self.search(search)
    if search
      where('wo_full LIKE ? OR staff_full LIKE ? OR cost_type LIKE ? OR fin_item LIKE ? OR staff_item like ? OR remark like ? OR invoice like ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end

end
