class CleanupsController < ApplicationController
  def index
  end

  def new
    @cleanup = Cleanup.new
  end

  def create
    @cleanup = Cleanup.new(cleanup_parameters)

    if @cleanup.save
      redirect_to fill_cleanup_path(@cleanup)
    else
      render 'cleanups/new'
    end
  end

  def fill
  end

  private

  def cleanup_parameters
    params.require(:cleanup).permit(:date, :place)
  end
end
