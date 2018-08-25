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
    @cleanup = Cleanup.find(params[:id])
  end

  def submit
    cleanup = Cleanup.find(params[:id])
    cleanup.update(submitted: true)

    redirect_to cleanups_path
  end

  private

  def cleanup_parameters
    params.require(:cleanup).permit(:date, :place, :user_id)
  end
end
