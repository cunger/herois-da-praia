class Item < ApplicationRecord
  belongs_to :cleanup

  restrict_type_of :type, to: ItemType
end
