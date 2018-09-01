require 'enumerated_type'

class ItemCategory
  include EnumeratedType

  declare :plastic_fragment,
          :code => 'plastic_fragment',
          :full_name => 'Plastic fragment'

  declare :plastic_bottle,
          :code => 'plastic_bottle',
          :full_name => 'Plastic bottle'

  declare :fishing_gear,
          :code => 'fishing_gear',
          :full_name => 'Fishing gear'

  declare :bottle_cap,
          :code => 'bottle_cap',
          :full_name => 'Bottle cap/lid'

  declare :cigarette_butt,
          :code => 'cigarette_butt',
          :full_name => 'Cigarette butt'

  declare :toothbrush,
          :code => 'toothbrush',
          :full_name => 'Toothbrush'

  declare :lighter,
          :code => 'lighter',
          :full_name => 'Lighter'

end
