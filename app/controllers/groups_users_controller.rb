class GroupsUsersController < ApplicationController
    def create
        @user = User.find_by(email: params[:email])
        if @user.nil?
            flash[:group_member_errors] = ["No user exists with this email"]
        elsif @user.id == current_user.id
            flash[:group_member_errors] = ["You can't add yourself to the group"]
        else
            @group = Group.find_by(id: params[:id], creator: current_user.id)
            @group_member = @group.users(user_id: @user.id, group_id: params[:group_id])
            if @group_member.nil?
                @friend = Friend.find_by(user_id: current_user.id, friend_id: @user.id)
                unless @friend.nil?
                    @group_member = GroupsUser.create(user_id: @user.id, group_id: params[:group_id])
                    unless @group_member.persisted?
                        flash[:group_member_errors] = @group_member.errors.full_messages
                    end
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



    