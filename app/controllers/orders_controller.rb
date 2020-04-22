class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.where(user_id: current_user.id)
    @counter = 0
    @invites = Invite.all
    @orders_from_invitations = Order.where(id: Invite.find(user_id = current_user.id).order_id)
    @orders = @orders.or(@orders_from_invitations)

  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    if (@order.save)
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

    @groups = Group.where(creator: current_user.id)
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

  def cancel_order
    @order_id = params[:id]
    @order = Order.find(id = @order_id)
    @order.status = "Canceled"
    @order.save
    redirect_to orders_path
  end

  def inviteGroup
    @group_id = params["inviteGroup-btn"]
    @order = Order.find(id = params['id'])
    @groupToInvite = Group.find_by(id: @group_id)
    @groupToInvite_members = @groupToInvite.users.all

    @groupToInvite_members.each do |user|
      if Invite.where(user_id: user.id, order_id: @order.id).present?
        flash[:danger] = "#{user.first_name} is already invited"
      elsif @new_invite = Invite.new()
        @new_invite.user = user
        @new_invite.order = @order
        @new_invite.save
      end
    end
    redirect_to inviteFriends_path
  end

  def finish
    @order_id = params[:id]
    @order = Order.find(id = @order_id)
    @order.status = "Finished"
    @order.save
    redirect_to orders_path
  end

  private def order_params
    params.require(:newOrder).permit(:orderType, :resturant, :menu)
  end
end
