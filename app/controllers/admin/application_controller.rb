class Admin::ApplicationController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_admin
  
  def check_admin
    if not current_user.admin?
      redirect_to "/404.html"
    end
  end
end