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

        @invited_arr = []
        @order = Order.find(id= params['id'])
        @invite = Invite.where(order_id: @order.id)
        @invite.each do |invitation|
          @invitedFriends= @invited_arr.push(User.find(id = invitation.user_id))
        end 
    end

    def invite
        puts params

        @friend_id = params['invite-btn'] 
        @friend = User.find(id=@friend_id)
        @order = Order.find(id= params['id'])
        p @order, @friend
        @new_invite = Invite.new()

        @new_invite.user = @friend
        @new_invite.order= @order
        puts @new_invite
        @new_invite.save
        
    end

    def update
    end

    def destroy
    end

    private def order_params
        params.require(:newOrder).permit(:orderType, :resturant, :menu)
    end
end
