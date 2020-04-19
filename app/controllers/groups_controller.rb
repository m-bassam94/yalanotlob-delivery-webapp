class GroupsController < ApplicationController
    def index
      @id = current_user.id
      @groups = Group.where(creator: @id).all
    end

    def show
      @groups = Group.where(creator: current_user.id)
        @group = Group.find_by(id: params[:id], creator: current_user.id)
        if @group.nil?
            flash[:group_error] = "No Group exists with this id"
            redirect_to :groups
        else
        @group_members =  @group.users.all
        # p @group_members
        # p @group
         end
    end
   
    def create
       @group = Group.new
       @group.creator = current_user.id
       @group.name = params[:name]
       @group.save
       redirect_back(fallback_location: root_path)
     end

    def destroy
      @group = Group.find params[:id]
      if @group.destroy
        flash[:delete_notice] = "Group successfully deleted"
        redirect_to groups_path
      end
    end
end