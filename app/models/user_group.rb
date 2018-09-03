require 'enumerated_type'

class UserGroup
  include EnumeratedType

  declare :lto_staff,
          :code => 'lto_staff',
          :full_name => 'LTO staff'

  declare :lto_volunteer,
          :code => 'lto_volunteer',
          :full_name => 'LTO volunteer'

  declare :resident,
          :code => 'resident',
          :full_name => 'Resident'

  declare :visitor,
          :code => 'visitor',
          :full_name => 'Visitor'

  def self.full_name(group)
    self.coerce(group).full_name
  end
end
