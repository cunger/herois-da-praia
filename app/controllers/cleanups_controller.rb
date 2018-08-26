class CleanupsController < ApplicationController
  def index
  end

  def new
    build_cleanup
  end

  def create
    build_cleanup
    save_cleanup or render new_cleanup_path
  end

  def show
    load_cleanup
  end

  def submit
    load_cleanup
    @cleanup.update(submitted: true) # This is a stub until we have an IDB.

    redirect_to cleanups_path
  end

  def destroy
    load_cleanup
    destroy_cleanup

    redirect_to cleanups_path
  end

  private

  def build_cleanup
    @cleanup ||= Cleanup.new(cleanup_parameters)
  end

  def load_cleanup
    @cleanup = Cleanup.find(params[:id])
  end

  def save_cleanup
    if @cleanup.save
      redirect_to @cleanup
    end
  end

  def destroy_cleanup
    @cleanup.destroy
  end

  def cleanup_parameters
    cleanup_params = params[:cleanup]
    cleanup_params ? cleanup_params.permit(:date, :place, :user_id) : {}
  end
end
