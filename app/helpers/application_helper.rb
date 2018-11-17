module ApplicationHelper
  def pretty_print_date(date)
    Date.parse(date.to_s).strftime("%d/%m/%Y")
  end

  def pretty_print_place(place)
    place.nil? ? 'unknown' : place.name
  end

  def to_plural(amount, string)
    # TODO This probably needs generalization at some point.
    if amount > 1 && string.include?('fragment')
      "#{amount} #{string.gsub('fragment', 'fragments')}"
    else
      pluralize(amount, string)
    end
  end
end
