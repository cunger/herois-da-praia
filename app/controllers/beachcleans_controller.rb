class BeachcleansController < ApplicationController
  def new
    @beachclean = new_beachclean
  end

  def create
    @beachclean = new_beachclean
    check_date

    if @beachclean.save
      redirect_to beachclean_path(@beachclean)
    else
      render :new
    end
  end

  def show
    @beachclean = find_beachclean || new_beachclean
    @items = all_items
  end

  def submit
    @user = find_user(user_uuid) || new_user(user_uuid)
    p @user
    @beachclean = find_beachclean || new_beachclean(@user.id)
    p @beachclean
    @beachclean.update beachclean_params.merge({ user_id: @user.id })

    params['items'].each_pair do |_, item|
      category = item['category']
      quantity = item['quantity'].to_i

      item = find_item(category) || new_item(category)
      item.update(quantity: quantity)
    end

    redirect_to verify_beachclean_path(uuid)
  end

  def verify
    @beachclean = find_beachclean
    @user = User.find(@beachclean.user_id)
    @estimated_weight = @beachclean.estimated_weight

    # TODO update user info
    # TODO upon POST: mark the beach clean as verified
  end

  def thanks
  end

  def destroy
    find_beachclean.destroy
  end

  private

  def uuid
    params[:uuid]
  end

  def user_uuid
    params[:beachclean][:user_uuid]
  end

  def beachclean_params
    params.fetch(:beachclean, {})
          .permit(:uuid, :date, :place_id, :user_id, :verified)
          .merge({ uuid: uuid })
  end

  def check_date
    flash.now[:date_missing] = true unless @beachclean[:date]
  end

  def find_beachclean
    Beachclean.where(uuid: uuid).take
  end

  def new_beachclean(user_id = User.default.id)
    Beachclean.create beachclean_params.merge({ user_id: user_id })
  end

  def find_user(user_uuid)
    User.where(uuid: user_uuid).take
  end

  def new_user(user_uuid)
    User.create({ uuid: user_uuid })
  end

  def find_item(category)
    Item.where(beachclean_id: @beachclean.id, category: category).take
  end

  def new_item(category)
    Item.new(beachclean_id: @beachclean.id, category: category, quantity: 0)
  end

  def all_items
    items = []
    ItemCategory.each do |category|
      items << (find_item(category.code) || new_item(category.code))
    end
    items
  end
end
