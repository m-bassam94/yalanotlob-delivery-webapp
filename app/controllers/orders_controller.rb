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
        redirect_to inviteFriends_path @order
    end

    def inviteFriends
        @friends_arr = []
        current_user.friendships.each do |friendship|
          @friendsToInvite= @friends_arr.push(User.find(id = friendship.friend_id))
        end
        
    end

    def update
    end

    def destroy
    end

    private def order_params
        params.require(:newOrder).permit(:orderType, :resturant, :menu)
    end
end
