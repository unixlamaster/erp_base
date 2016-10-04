class Upload < ActiveRecord::Base
  belongs_to :workobject
  belongs_to :staff
  attr_accessible :filename, :size, :workobject_id, :state, :staff, :task_id, :contract_id
#  has_attached_file :upload

  def save_upload(file,wo,staff_id,flag)
    logger.debug "=== #{wo.inspect}\n"
    name =  file.original_filename
    directory = case flag
               when "wo"
                 "uploads/#{wo['workobject_id']}"
               when "ts"
                 "uploads_task/#{wo['task_id']}"
               when "co"
                 "uploads_contract/#{wo['contract_id']}"
               end
   # create the file path
    Dir.mkdir(directory) unless FileTest.directory?(directory)
    logger.debug "+++ #{name}\n"
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(file.read) }
    write_attribute(:filename, name)
    write_attribute(:workobject_id, wo["workobject_id"])
    write_attribute(:task_id, wo["task_id"])
    write_attribute(:contract_id, wo["contract_id"])
    write_attribute(:size, File.size(path))
    write_attribute(:state, "new")
    write_attribute(:staff, @staff_id)
    save
  end

  def to_jq_upload
    {
      "name" => read_attribute(:filename),
      "size" => read_attribute(:size),
      "url" => upload.url(:original),
      "delete_url" => upload_path(self),
      "delete_type" => "DELETE" 
    }
  end
end
