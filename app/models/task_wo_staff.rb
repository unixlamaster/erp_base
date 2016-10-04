class TaskWoStaff < ActiveRecord::Base
  self.table_name = "task_wo_staff"

  attr_accessible :id, :description, :wo_id, :wo_fulladdr, :from_name, :to_name, :edate, :progress, :sdate, :state, :staff_id, :staff_from_id, :priority
  validates :description, presence: true
  validates :staff_id, presence: true
  validates :staff_from_id, presence: true

 
  def self.search(search)
    if search
     where('description LIKE ? OR sdate LIKE ? OR edate LIKE ?  OR state LIKE ? OR wo_fulladdr LIKE ? OR from_name LIKE ? OR to_name Like ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%")
      else
     scoped
    end
   end
end
