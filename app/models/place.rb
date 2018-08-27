require 'enumerated_type'

# Note: This is a stub and will probably change.
# For example, should allow to capture specific GPS location.
class Place
  include EnumeratedType

  declare :guinjata,
          :code => 'guinjata',
          :fullName => 'Guinjata'

  declare :guinjataPoint,
          :code => 'guinjata_point',
          :fullName => 'Guinjata point'

  declare :paindane,
          :code => 'paindane',
          :fullName => 'Paindane'

  declare :other,
          :code => 'other',
          :fullName => 'Other'

  def self.as_select_options
    options = []

    self.each do |place|
      options << [place.fullName, place.code]
    end

    options
  end
end
