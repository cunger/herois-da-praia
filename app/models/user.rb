class User < ApplicationRecord
  restrict_type_of :group, to: UserGroup

end
