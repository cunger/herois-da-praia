require 'enumerated_type'

class ItemCategory
  include EnumeratedType

  declare :plastic_fragment,
          :code => 'plastic_fragment',
          :full_name => 'Plastic fragment',
          :weight => 0.07

  declare :plastic_bottle,
          :code => 'plastic_bottle',
          :full_name => 'Plastic bottle',
          :weight => 0.07

  declare :bottle_cap,
          :code => 'bottle_cap',
          :full_name => 'Bottle cap/lid',
          :weight => 0.008

  declare :fishing_gear,
          :code => 'fishing_gear',
          :full_name => 'Fishing gear',
          :weight => 0.09

  declare :rope,
      	  :code => 'rope',
      	  :full_name => 'Rope',
      	  :weight => 0.05

  declare :cigarette_butt,
          :code => 'cigarette_butt',
          :full_name => 'Cigarette butt',
          :weight => 0.006

  declare :toothbrush,
          :code => 'toothbrush',
          :full_name => 'Toothbrush',
          :weight => 0.08

  declare :shoe,
          :code => 'shoe',
          :full_name => 'Shoe',
          :weight => 0.1

  declare :lighter,
          :code => 'lighter',
          :full_name => 'Lighter',
          :weight => 0.05

  declare :other,
          :code => 'other',
          :full_name => 'Other',
          :weight => 0.1

  def self.full_name(category)
    self.coerce(category).full_name
  end
end
