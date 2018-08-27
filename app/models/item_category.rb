require 'enumerated_type'

class ItemCategory
  include EnumeratedType

  declare :plastic_fragment_s,
          :code => 'plastic_fragment_s',
          :fullName => 'Plastic fragment S'

  declare :plastic_fragment_m,
          :code => 'plastic_fragment_m',
          :fullName => 'Plastic fragment M'

  declare :plastic_fragment_l,
          :code => 'plastic_fragment_l',
          :fullName => 'Plastic fragment L'

  declare :plastic_bottle,
          :code => 'plastic_bottle',
          :fullName => 'Plastic bottle'

  declare :bottle_cap,
          :code => 'bottle_cap',
          :fullName => 'Bottle cap or lid'

  declare :cigarette_butt,
          :code => 'cigarette_butt',
          :fullName => 'Cigarette butt'
end
