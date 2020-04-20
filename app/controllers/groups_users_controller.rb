class GroupsUsersController < ApplicationController
  add_flash_types :success, :warning, :danger, :info
  def create
    @user = User.find_by(email: params[:email])
    if @user.nil?
      flash[:group_member_errors] = ["No user exists with this email"]
    elsif @user.id == current_user.id
      flash[:group_member_errors] = ["You can't add yourself to the group"]
    else
      @group = Group.find_by(id: params[:group_id], creator: current_user.id)
      @group_member = @group.users.find_by(id: @user.id)
      if @group_member.nil?
        if Friendship.where(friend_id: @user.id).present?
          @group.users << @user
        else
          flash[:group_member_errors] = ["User isn't a friend"]
        end
      else
        flash[:group_member_errors] = ["User already exist in the group"]
      end
    end
    redirect_to group_url(:id => params[:group_id])
  end

  # render :template => 'groups/show'


  def destroy
    @group = Group.find_by(id: params[:group_id], creator: current_user.id)
    @group_member = @group.users.find params[:user_id]
    @group.users.delete @group_member
    redirect_back(fallback_location: root_path)
  end


end



    