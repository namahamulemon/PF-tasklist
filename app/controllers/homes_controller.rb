class HomesController < ApplicationController
  before_action :authenticate_user!
  def top
    @user = current_user
    @events = Event.all
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end
end
