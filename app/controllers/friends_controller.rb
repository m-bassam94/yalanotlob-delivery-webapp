class FriendsController < ApplicationController
  def index

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
    if @new_friend.present? and Friendship.where(friend_id: @new_friend.id).present?
      flash[:danger] = "#{@new_friend.first_name} is already in your friend list."
    elsif @new_friend.present? and not Friendship.where(friend_id: @new_friend.id).present?
      @friend = User.where(:email => @email).first
      @new_friendship = Friendship.new
      @new_friendship.friend_id = @friend.id
      @new_friendship.user_id = current_user.id

      if @new_friendship.save
        # TODO ajax show new friends
        render 'show'
      else
        render 'new'
      end

      redirect_to friends_path
    else
      # TODO show error messages
      flash[:danger] = "Email entered doesn't match a valid user's email."
    end

    @deleted_friendship = current_user.friendships.where(:friend_id => @delete_id)
    if @deleted_friendship.present?
      # TODO ajax deletion
      @deleted_friendship.delete_all
    end

    respond_to do |format|
      show.html.erb
    end
  end


  def show
    unless user_signed_in?
      flash[:alert] = "You're not signed in."
      authenticate_user!
    else
      @friends_arr = []
      current_user.friendships.each do |friendship|
        @friends = @friends_arr.push(User.find(id = friendship.friend_id))
      end
    end

  end

  def destroy
    #p "ENTERED DESTROY"
  end

end
