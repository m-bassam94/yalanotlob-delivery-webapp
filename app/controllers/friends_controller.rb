class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends_arr = []
    current_user.friendships.each do |friendship|
      @friends = @friends_arr.push(User.find(id = friendship.friend_id))
    end
  end

  def new
    @new_friendship = current_user.friendship.new()
    @errors = Array.new

  end

  def create
    @errors = Array.new
    @email = params["email-invite"]
    @delete_id = params["unfriend-btn"]

    @new_friend = User.where(:email => @email).first
    if (params["email-invite"] === "" or @new_friend.nil?) and @delete_id.nil?
      # TODO show error messages
      flash[:danger] = "Email entered doesn't match a valid user's email."
    elsif not @delete_id.nil?
      @deleted_friendship = current_user.friendships.where(:friend_id => @delete_id)
      # TODO ajax deletion
      @deleted_friendship.delete_all

    elsif @new_friend.present? and Friendship.where(friend_id: @new_friend.id).present?
      flash[:danger] = "#{@new_friend.first_name} is already in your friend list."
    elsif @new_friend.present? and not Friendship.where(friend_id: @new_friend.id).present?
      @do_break = nil
      @friend = User.where(:email => @email).first
      if @friend == current_user
        flash[:danger] = "You don't have to add yourself as a friend, I'm your friend."
      else
        Notification.create recipient_id: @friend.id, actor_id: current_user.id, action: "wants to add you as a friend.", category: 2, model: "friends"


      end


    end


    redirect_to friends_path
  end


  def show

  end

  def accept
    friend_id = params[:id]
    p "ACCEPTED"
    @new_friend = User.where(:id => friend_id).first
    @new_self_friendship = Friendship.new
    @new_self_friendship.friend_id = friend_id
    @new_self_friendship.user_id = current_user.id

    @new_reverse_friendship = Friendship.new
    @new_reverse_friendship.friend_id = current_user.id
    @new_reverse_friendship.user_id = friend_id


    if @new_self_friendship.save
      #@new_notification = Notification.create recipient_id: @friend.id, actor_id: current_user.id, action: "added you as a friend", category: 2, notifiable: @new_friendship
      # TODO ajax show new friends
      # TEMP TODO refresh page
    end

    if @new_reverse_friendship.save
      #@new_notification = Notification.create recipient_id: @friend.id, actor_id: current_user.id, action: "added you as a friend", category: 2, notifiable: @new_friendship
      # TODO ajax show new friends
      # TEMP TODO refresh page
    end

    redirect_to friends_path

  end

  def decline
    id= params[:id]
    notification = Notification.where(:actor_id => id) and Notification.where(:recipient_id => current_user.id )
    Notification.delete(notification)
    redirect_to friends_path

  end

  def destroy
    # p "ENTERED DESTROY"
  end

end
