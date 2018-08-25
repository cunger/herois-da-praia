require 'enumerated_type'

class UserGroup
  include EnumeratedType

  declare :LTOstaff,
          :code => 'lto_staff',
          :fullName => 'LTO staff'

  declare :LTOvolunteer,
          :code => 'lto_volunteer',
          :fullName => 'LTO volunteer'

  declare :resident,
          :code => 'resident',
          :fullName => 'Resident'

  declare :visitor,
          :code => 'visitor',
          :fullName => 'Visitor'
end
