class Scope < ApplicationRecord
  belongs_to :user

  validates :date, presence: true

  def pretty_printed_date
    Date.parse(self.date.to_s).strftime("%d/%m/%Y")
  end

  def place_name
    Place.coerce(self.place).fullName
  rescue
    'Unknown'
  end
end
