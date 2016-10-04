class Post < ActiveRecord::Base
  belongs_to :task
  belongs_to :staff
  belongs_to :chif, :class_name => 'Staff', :foreign_key => 'chif_id'
  belongs_to :workobject
  attr_accessible :staff_id, :staff_name, :text, :workobject_id, :wobj_name, :task_id, :chif_id, :chif_name, :brigada, :amount
  validates :staff_id, presence: true
  validates :text, presence: true
  validates :workobject_id, presence: true
  validates :chif_id, presence: true

  def self.search(search)
    if search
     where('staff_name LIKE ? OR text LIKE ? OR wobj_name LIKE ?  OR chif_name LIKE ? OR brigada LIKE ? OR amount LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%")
      else
     scoped
    end
   end

end
