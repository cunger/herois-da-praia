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
    @place = find_place || new_place
    @beachclean = find_beachclean || new_beachclean(@user.id)
    @beachclean.update beachclean_params.merge({ user_id: @user.id, place_id: @place.id })

    params['items'].each_pair do |_, item|
      category = item['category']
      quantity = item['quantity'].to_i

      item = find_item(category) || new_item(category)
      item.update(quantity: quantity)
    end

    redirect_to beachclean_summary_path(@beachclean.uuid)
  end

  def summary
    @beachclean = find_beachclean
    @items = all_items
  end

  def sign
    @beachclean = find_beachclean || new_beachclean
    @weight_in_kg = @beachclean.weight_in_gram / 1000
  end

  def create_signature
    @beachclean = find_beachclean
    @beachclean.update({ :signed => true })
    @user = User.find(@beachclean.user_id)
    @user.update params.permit(:group, :name, :email)

    redirect_to beachclean_thanks_path
  end

  def thanks
  end

  def destroy
    find_beachclean.destroy
  end

  private

  def uuid
    params[:uuid] || params[:beachclean_uuid]
  end

  def user_uuid
    params[:beachclean][:user_uuid]
  end

  def place_id
    params[:beachclean][:place_id]
  end

  def place_name
    params[:beachclean][:place_name]
  end

  def place_latitude
    params[:beachclean][:place_latitude]
  end

  def place_longitude
    params[:beachclean][:place_longitude]
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

  def find_place
    Place.where(id: place_id).take
  end

  def new_place
    Place.create({ name: place_name, latitude: place_latitude, longitude: place_longitude })
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
