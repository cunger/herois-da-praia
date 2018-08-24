class WelcomeController < ApplicationController
  def start
    @user = User.default
  end

  def info
  end
end
