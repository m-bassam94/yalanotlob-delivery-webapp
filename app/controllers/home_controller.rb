class HomeController < ApplicationController
   before_action :authenticate_user!

  def index
    orders = Order.where(user_id: current_user.id)
    p orders
    invites = Invite.where(user_id: current_user.id)
    p invites
    @orders_from_invitations = []
    invites.each do |invite|
      @orders_from_invitations.append(Order.where(id: invite.order_id).first)
    end
    p @orders_from_invitations

    orders.each do |order|
      @orders_from_invitations.append(order)
    end
    @orders_from_invitations = @orders_from_invitations[0..4]
    p @orders_from_invitations
  end

  def show
  end

end
