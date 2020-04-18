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
    if @new_friend.present? and not Friendship.where(friend_id: @new_friend.id).present?
      @friend = User.where(:email => @email).first
      @new_friendship = Friendship.new
      @new_friendship.friend_id = @friend.id
      @new_friendship.user_id = current_user.id

      if @new_friendship.save
        # TODO show new friends async
        p "SAAAAVEEEEED"
        render 'show'
      else
        render 'new'
      end

      redirect_to friends_path
    else
      # TODO show error messages
      p "NOT A VALID EMAIL FOR USER"
      @errors.push("error": "Email entered doesn't match a valid user's email.")
      p @errors
    end

    @deleted_friendship = current_user.friendships.where(:friend_id => @delete_id)
    if @deleted_friendship.present?
      # TODO show async deletion
      @deleted_friendship.delete_all
    end


  end


  def show
    unless user_signed_in?
      authenticate_user!
    else
      @friends_arr = []
      current_user.friendships.each do |friendship|
        @friends = @friends_arr.push(User.find(id = friendship.friend_id))
      end
      p @friends
    end

  end

  def destroy
    p "ENTERED DESTROY"
  end

end
