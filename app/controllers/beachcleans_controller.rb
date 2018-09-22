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

  def update
    p params
    # TODO params[:beachclean]
    # TODO params[:items]

    redirect_to submit_beachclean_path(@beachclean)
  end

  def submit
  end

  def verify
    # TODO take user credentials and mark the beach clean as verified
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

  def beachclean_params
    beachclean_params = params[:beachclean]
    beachclean_params ? beachclean_params.permit(:date, :place_id, :user_id, :verified) : {}
  end

  def check_date
    flash.now[:date_missing] = true unless @beachclean[:date]
  end

  def find_beachclean
    Beachclean.where(uuid: uuid).take
  end

  def new_beachclean
    beachclean = Beachclean.new beachclean_params
    beachclean.uuid = uuid
    beachclean
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
    p items
    items
  end

end
