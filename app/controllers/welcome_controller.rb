class WelcomeController < ApplicationController
  def start
    Rails.logger.info 'Checking database...'
    Rails.logger.info Places.all
  end

  def info
  end
end
