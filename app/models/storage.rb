class Storage < ActiveRecord::Base
 attr_accessible :id, :name, :unit, :mass, :address 
 validates :name, presence: true
 validates :address, presence: true
 validates :unit, presence: true
 validates :mass, presence: true
 
 
 def self.search(search)
    if search
      where('name LIKE ? OR address LIKE ? OR unit LIKE ? OR mass LIKE ?',"%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end
  
end
