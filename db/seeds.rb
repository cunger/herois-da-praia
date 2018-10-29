## Pre-defined users

# Default user that is used as long as we don't know anything about the user.
User.create!(
  name: 'DEFAULT',
  group: :visitor
)

# Admin.
User.create!(
  name: 'Christina',
  email: 'buoyantcode@gmail.com',
  group: :dev
)

# LTO staff user.
User.create!(
  name: 'LTO',
  email: 'info@lovetheoceans.org',
  group: :lto_staff
)

## Pre-defined places

Place.create!(
  name: 'Guinjata'
)

Place.create!(
  name: 'Paindane'
)
