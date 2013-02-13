class Project < ActiveRecord::Base
  attr_accessible :content, :description, :position, :priority, :published, :slug, :title

  enum_attr :priority, %w(^primary secondary), :nil => false do
    label :primary   => 'Principale'
    label :secondary => 'Secondaire'
  end
end
