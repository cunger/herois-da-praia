require 'enumerated_type'

class ItemCategory
  include EnumeratedType

  declare :plastic_fragment_s,
          :code => 'plastic_fragment_s',
          :full_name => 'Plastic fragment S', # (< 1cm)
          :weight_in_gram => 0.11

  declare :plastic_fragment_m,
          :code => 'plastic_fragment_m',
          :full_name => 'Plastic fragment M', # (1-2.5cm)
          :weight_in_gram => 0.45

  declare :plastic_fragment_l,
          :code => 'plastic_fragment_l',
          :full_name => 'Plastic fragment L', # (> 2.5cm)
          :weight_in_gram => 4.5

  declare :metal_bottle_cap,
          :code => 'metal_bottle_cap',
          :full_name => 'Metal bottle cap',
          :weight_in_gram => 2.4

  declare :plastic_bottle_cap,
          :code => 'plastic_bottle_cap',
          :full_name => 'Plastic bottle cap',
          :weight_in_gram => 3.13

  declare :plastic_bottle,
          :code => 'plastic_bottle',
          :full_name => 'Plastic bottle',
          :weight_in_gram => 27.5

  declare :glas_bottle,
          :code => 'glas_bottle',
          :full_name => 'Glas bottle',
          :weight_in_gram => 465.0

  declare :aluminum_can,
          :code => 'aluminum_can',
          :full_name => 'Aluminum can',
          :weight_in_gram => 13.6

  declare :food_wrapper,
          :code => 'food_wrapper',
          :full_name => 'Food wrapper',
          :weight_in_gram => 5.0

  declare :straw,
          :code => 'straw',
          :full_name => 'Straw',
          :weight_in_gram => 0.42

  declare :plastic_bag,
          :code => 'plastic_bag',
          :full_name => 'Plastic bag',
          :weight_in_gram => 28.75

  declare :toothbrush,
          :code => 'toothbrush',
          :full_name => 'Toothbrush',
          :weight_in_gram => 8.75

  declare :fishing_gear,
          :code => 'fishing_gear',
          :full_name => 'Fishing gear',
          :weight_in_gram => 4.17

  declare :rope,
      	  :code => 'rope',
      	  :full_name => 'Rope',
      	  :weight_in_gram => 2.86

  declare :cigarette_butt,
          :code => 'cigarette_butt',
          :full_name => 'Cigarette butt',
          :weight_in_gram => 3.4

  declare :shoe,
          :code => 'shoe',
          :full_name => 'Shoe',
          :weight_in_gram => 65.0

  declare :foam,
          :code => 'foam',
          :full_name => 'Foam',
          :weight_in_gram => 6.25

  declare :fabric,
          :code => 'fabric',
          :full_name => 'Fabric',
          :weight_in_gram => 22.5

  declare :paper,
          :code => 'paper',
          :full_name => 'Paper',
          :weight_in_gram => 1.2

  declare :glas,
          :code => 'glas',
          :full_name => 'Glas',
          :weight_in_gram => 46.5

  declare :other,
          :code => 'other',
          :full_name => 'Other',
          :weight_in_gram => 24.38

  def self.full_name(category)
    self.coerce(category).full_name
  end
end
