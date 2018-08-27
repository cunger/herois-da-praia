class WelcomeController < ApplicationController
  def start
    @user = User.default
  end
end
