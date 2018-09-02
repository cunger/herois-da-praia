class ScopesController < ApplicationController
  # Scopes are shared among beach clean and whale watching routes.
  # The destination parameter ensures that redirecting from scope
  # goes to the intended destination:
  # /beachclean -> /scope/new?for=beachclean -> /scope/:id/items
  # /whalewatch -> /scope/new?for=whalewatch -> /scope/:id/observations

  before_action :build_scope, :set_destination, only: [:new, :create]

  def index
    collect_activities
  end

  def new
  end

  def create
    if save_scope
      redirect_to_logging_page
    else
      render :new
    end
  end

  private

  def get_user_id
    # Default user for now. Will later be in the session.
    1
  end

  def build_scope
    @scope = Scope.new scope_params
  end

  def scope_params
    scope_params = params[:scope]
    scope_params ? scope_params.permit(:date, :place, :user_id) : {}
  end

  def save_scope
    flash.now[:date_missing] = true unless @scope[:date]
    @scope.save
  end

  def set_destination
    @destination = params[:for] || params[:scope][:for]
  end

  def redirect_to_logging_page
    case @destination
    when 'beachclean'
      redirect_to items_scope_path @scope
    when 'whalewatch'
      redirect_to scope_observations_path @scope
    end
  end

  def collect_activities
    @activities = []
    Scope.where(user_id: get_user_id).each do |scope|
      item_count = Item.where(scope_id: scope.id).sum(:quantity)

      @activities << {
        scope_id: scope.id,
        date: scope.pretty_printed_date,
        place: scope.place_name,
        beachclean: true,
        items: item_count,
        whalewatch: false
      }
    end
  end
end
