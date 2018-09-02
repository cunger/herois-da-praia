class ItemsController < ApplicationController
  before_action :get_scope, :build_item_list

  def index
  end

  def edit
  end

  def update
    params[:items].each do |category, count|
      item = find_item(category)
      item.quantity = count
      item.save
    end

    redirect_to beachclean_path
  end

  def destroy
    @items.each { |item| item.destroy }
    @scope.destroy
  end

  private

  def scope_id
    params[:id]
  end

  def get_scope
    @scope = Scope.find(scope_id)
  end

  def find_item(category)
    Item.where(scope_id: scope_id, category: category).take ||
    Item.new(category: category, quantity: 0, scope_id: scope_id)
  end

  def build_item_list
    @items = []
    ItemCategory.each do |category|
      @items << find_item(category.code)
    end
  end
end
