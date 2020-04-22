class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.where(user_id: current_user.id)
    @counter = 0
    @invites = Invite.all
  end

  def new
    @order= Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    if(@order.save)
      redirect_to inviteFriends_path(@order)
    else
      render 'new'
    end    
  end

  def inviteFriends
    @friends_arr = []
    current_user.friendships.each do |friendship|
      @friendsToInvite = @friends_arr.push(User.find(id = friendship.friend_id))
    end

    @invited_arr = []
    @order = Order.find(id = params['id'])
    @invite = Invite.where(order_id: @order.id)
    @invite.each do |invitation|
      @invitedFriends = @invited_arr.push(User.find(id = invitation.user_id))
    end

    @joined_arr = []
    @joined = Invite.where(order_id: @order.id, joined: true)
    @joined.each do |invitation|
      @joinedFriends = @joined_arr.push(User.find(id = invitation.user_id))
    end    
  end

  def cancel
    @cancel_id = params["cancel-btn"]
    @order = Order.find(id = params['id'])
    @invite = Invite.where(order_id: @order.id)
    p 'cancel id ====', @cancel_id
    if not @cancel_id.nil?
      p params
      @deleted_invitation = @invite.where(user_id: @cancel_id)
      @deleted_invitation.delete_all
    end
    redirect_to inviteFriends_path
  end

  def invite
    @friend_id = params['invite-btn']
    @friend = User.find(id = @friend_id)
    @order = Order.find(id = params['id'])

    if Invite.where(user_id: @friend.id, order_id: @order.id).present?
      flash[:danger] = "#{@friend.first_name} is already invited"
      redirect_to inviteFriends_path
    elsif @new_invite = Invite.new()
      @new_invite.user = @friend
      @new_invite.order = @order
      @new_invite.save
      redirect_to inviteFriends_path
    end
  end


  private def order_params
    params.require(:newOrder).permit(:orderType, :resturant, :menu)
  end
end
