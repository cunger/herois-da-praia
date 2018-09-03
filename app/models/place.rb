require 'enumerated_type'

# Note: This is a stub and will probably change.
# Should allow to capture specific GPS location.
class Place
  include EnumeratedType

  declare :guinjata,
          :code => 'guinjata',
          :full_name => 'Guinjata'

  declare :paindane,
          :code => 'paindane',
          :full_name => 'Paindane'

  declare :other,
          :code => 'other',
          :full_name => 'Other'

  declare :unknown,
          :code => 'unknown',
          :full_name => 'Unknown'

  def self.full_name(place)
    self.coerce(place).full_name
  rescue
    'Unknown'
  end

  def self.as_select_options
    options = []

    self.each do |place|
      options << [place.full_name, place.code]
    end

    options
  end
end
