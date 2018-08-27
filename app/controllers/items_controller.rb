class ItemsController < ApplicationController
  def plus
    load_item
    increase_quantity
    save_item

    redirect_to scope_path(scope)
  end

  def minus
    load_item
    decrease_quantity
    save_item

    redirect_to scope_path(scope)
  end

  private

  def load_item
    @item ||= Item.find(params[:id])
  end

  def save_item
    @item.save
  end

  def increase_quantity
    @item.update(quantity: @item.quantity + 1)
  end

  def decrease_quantity
    @item.update(quantity: @item.quantity - 1)
  end

  def scope
    scope.find(@item.scope_id)
  end
end
