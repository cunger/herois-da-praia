class User < ApplicationRecord
  restrict_type_of :group, to: UserGroup

  def self.default
    User.find_or_create_by name: 'Momo'
  end
end
