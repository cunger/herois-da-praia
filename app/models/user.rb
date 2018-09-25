class User < ApplicationRecord
  restrict_type_of :group, to: UserGroup

  def self.default
    User.where(name: 'DEFAULT').take
  end
end
