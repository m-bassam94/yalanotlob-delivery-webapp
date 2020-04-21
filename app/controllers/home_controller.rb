class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.where(user_id: current_user.id).limit(10)
  end

  def show
  end

end
