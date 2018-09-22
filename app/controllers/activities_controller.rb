class ActivitiesController < ApplicationController
  def index
    # TODO This should list only the activities of the user.
    # TODO User needs to authenticate for this?
    # TODO Otherwise just show PouchDB contents.
    @activities = all_activities
  end

  private

  def all_activities
    activities = []

    # Beachclean.where(user: user_id).each do |log|
    #   item_count = Item.where(log_id: log.id).sum(:quantity)
    #
    #   activities << {
    #     log_id: log.id,
    #     date: log.date,
    #     place: log.place,
    #     beachclean: true,
    #     items: item_count,
    #     whalewatch: false
    #   }
    # end

    activities
  end
end
