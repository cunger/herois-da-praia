class Place < ApplicationRecord
  def self.select_options
    [['Guinjata', 1], ['Paindane', 2], ['Other', nil]]
  end
end
