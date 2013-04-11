class Project < ActiveRecord::Base
  attr_accessible :content, :description, :position, :priority, :published, :slug, :tag_ids, :title

  has_and_belongs_to_many :tags

  has_many :assets, :dependent => :destroy
  accepts_nested_attributes_for :assets, :allow_destroy => true

  enum_attr :priority, %w(^primary secondary), :nil => false do
    label :primary   => 'Principale'
    label :secondary => 'Secondaire'
  end
end
