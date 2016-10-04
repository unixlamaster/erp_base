class DatePostsUploads < ActiveRecord::Base
  self.table_name = "date_posts_uploads"

  attr_accessible :dd, :workobject_id, :task_id
 
end
