class Message

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :firstname, :lastname, :email, :additional, :body

  validates :firstname, :lastname, :email, :body, :presence => true
  validates :email, :format => {  :with => %r{.+@.+\..+},
                                  :message => "n'est pas au bon format."
                                },
                    :allow_blank => false

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end