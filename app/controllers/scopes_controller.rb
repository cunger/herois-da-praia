class ScopesController < ApplicationController
  def new
    build_scope
    @for = params[:for]
  end

  def create
    build_scope

    if @scope.save
      redirect_to_logging_page
    else
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

  def redirect_to_logging_page
    redirect_to items_scope_path(@scope) if params[:scope][:for] == 'beachclean'
    redirect_to scope_observations_path(@scope) if params[:scope][:for] == 'whalewatch'
  end
end
