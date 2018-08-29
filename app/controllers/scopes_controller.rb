class ScopesController < ApplicationController
  def new
    build_scope
  end

  def create
    build_scope

    if @scope.save
      redirect_to scope_items_path(@scope)
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
end
