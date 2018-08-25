require 'enumerated_type'

class ItemType
  include EnumeratedType

  declare :fragment_s, :code => 'plastic_fragment_s', :fullName => 'Plastic Fragment S (< 2cm)'
  declare :fragment_m, :code => 'plastic_fragment_m', :fullName => 'Plastic Fragment M (2-5cm)'
  declare :fragment_l, :code => 'plastic_fragment_l', :fullName => 'Plastic Fragment L (> 5cm)'
end
