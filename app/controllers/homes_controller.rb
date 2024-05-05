class HomesController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  
  def top
    redirect_to user_path(current_user) if user_signed_in?
  end

  def about
    
  end
end
