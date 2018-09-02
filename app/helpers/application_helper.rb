module ApplicationHelper
  def pretty_print_date(date)
    Date.parse(date.to_s).strftime("%d/%m/%Y")
  end

  def pretty_print_place(place)
    Place.fullName(place)
  end
end
