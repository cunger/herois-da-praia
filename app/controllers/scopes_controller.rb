class ScopesController < ApplicationController
  # Scopes are shared among beach clean and whale watching routes.
  # The destination parameter ensures that redirecting from scope goes
  # to the intended destination:
  # /beachclean -> /scope/new?for=beachclean -> /scope/:id/items
  # /whalewatch -> /scope/new?for-whalewatch -> /scope/:id/observations

  def new
    build_scope
    set_destination
  end

  def create
    build_scope

    if save_scope
      redirect_to_logging_page
    else
      set_destination
      render new_scope_path
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
    @for = params[:for] || destination
  end

  def destination
    params[:scope][:for]
  end

  def redirect_to_logging_page
    redirect_to items_scope_path(@scope) if destination == 'beachclean'
    redirect_to scope_observations_path(@scope) if destination == 'whalewatch'
  end
end
