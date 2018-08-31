class ScopesController < ApplicationController
  # Scopes are shared among beach clean and whale watching routes.
  # The destination parameter ensures that redirecting from scope
  # goes to the intended destination:
  # /beachclean -> /scope/new?for=beachclean -> /scope/:id/items
  # /whalewatch -> /scope/new?for=whalewatch -> /scope/:id/observations

  before_action :build_scope, :set_destination, only: [:new, :create]

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
end
