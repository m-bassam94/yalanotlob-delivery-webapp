class FriendsController < ApplicationController
  def index

  end

  def new
    @new_friend = current_user.friendship.new()
  end

  def create
    @email = params["email-invite"]
    p params
    p @email

    if User.where(:email => @email).first.present?
      p "TESTTT"
      @friend = User.where(:email =>  @email).first
      p "TEXT", @friend
      @new_friend = Friendship.new
      @new_friend.friend_id = @friend.id
      @new_friend.user_id = current_user.id
      p @new_friend
      p "TESTTT"
      render 'show'
      if @new_friend.save
        p "SAAAAVEEEEED"
        render 'show'
      else
        render 'new'
      end
    end
  end

  def show
    @friends_arr = []
    current_user.friendships.each do |frienship|
      @friends = @friends_arr.push(User.find(id=frienship.friend_id))
    end
    p @friends
  end


end
