class OrdersController < ApplicationController

  def index
    @orders = Order.where(user_id: current_user.id)
    @counter = 0
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @order = Order.new
    @order.user_id = current_user.id
    @order.save
    redirect_back(fallback_location: root_path)
  end

  def update
  end

  def destroy
  end
end
