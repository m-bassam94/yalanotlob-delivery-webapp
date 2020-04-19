class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  @group = Group.new
  @group.users.all

end
