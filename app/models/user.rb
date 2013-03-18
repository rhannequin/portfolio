class User < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :role

  def is_admin?
    self.role == 'admin'
  end
end
