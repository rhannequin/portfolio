class Project < ActiveRecord::Base
  attr_accessible :content, :description, :position, :priority, :published, :slug, :tag_ids, :title, :uploads_attributes

  has_and_belongs_to_many :tags

  has_many :uploads
  accepts_nested_attributes_for :uploads, :allow_destroy => true

  enum_attr :priority, %w(^primary secondary), :nil => false do
    label :primary   => 'Principale'
    label :secondary => 'Secondaire'
  end

  def self.related(current_project, tag_list, limit = 5)
    related = []
    relatedIds = []
    tag_list.each do |tag|
      Tag.find(tag.id).projects.where(:published => true).order('position').each do |project|
        id = project.id
        unless relatedIds.include?(id) or id == current_project.id
          related << project
          relatedIds << id
        end
      end
    end
    return related[0..1]
  end
end
