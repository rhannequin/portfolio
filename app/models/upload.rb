class Upload < ActiveRecord::Base
  attr_accessible :upload, :project_id
  belongs_to :project
  has_attached_file :upload,
      :styles => {
        :thumb  => "100x100>",
        :medium  => "300x300>",
        :large  => "600x600"
      }
end