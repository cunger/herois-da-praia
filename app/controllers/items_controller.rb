class ItemsController < ApplicationController
  def create
    load_item
    increase_quantity
    save_item

    redirect_to cleanup_path(cleanup)
  end

  def destroy
    load_item
    decrease_quantity
    save_item

    redirect_to cleanup_path(cleanup)
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

  def cleanup
    Cleanup.find(@item.cleanup_id)
  end
end
