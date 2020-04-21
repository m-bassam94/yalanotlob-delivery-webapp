class OrdersController < ApplicationController

    def index
        
    end

    def show
    end

    def new
    end

    def edit
    end

    def create
        @order = Order.new(order_params)
        @order.user_id = current_user.id
        @order.save
        redirect_back(fallback_location: root_path)
    end

    def update
    end

    def destroy
    end

    private def order_params
        params.require(:newOrder).permit(:orderType, :resturant, :menu)
    end
end
