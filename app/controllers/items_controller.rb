class ItemsController < ApplicationController
  before_action :get_scope, :build_item_list, only: [:index, :edit]

  def index
  end

  def edit
  end

  def destroy
  end

  private

  def get_scope
    @scope = Scope.find(params[:id])
  end

  def build_item_list
    @items = []
    ItemCategory.each do |category|
      @items << Item.new(category: category, quantity: 0, scope_id: @scope.id)
    end
  end
end
