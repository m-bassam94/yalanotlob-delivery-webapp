class HomeController < ApplicationController
   before_action :authenticate_user!

  def index
    @orders = Order.where(user_id: current_user.id)
    @invites = Invite.all
    @orders_from_invitations = Order.where(id: Invite.find(user_id = current_user.id).order_id)
    @orders = @orders.or(@orders_from_invitations).reorder('created_at DESC').limit(5)

    @friends = User.where(id: Friendship.find(user_id = current_user.id).friend_id)
  end

  def show
  end

end
