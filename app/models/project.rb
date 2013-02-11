class Project < ActiveRecord::Base
  attr_accessible :content, :description, :position, :priority, :slug, :title
end
