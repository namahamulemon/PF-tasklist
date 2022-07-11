class Public::EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      flash[:success] = 'タスクが投稿されました'
      redirect_to events_path(@event.id)
    else
      flash[:danger] = 'タスクが投稿されません'
      @event = Event.new
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    @user = current_user
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

   if @event.update(event_params)
    flash[:success] = 'タスクが編集されました'
    redirect_to @event
   else
    flash.now[:danger] = 'タスクが編集されませんでした'
    render :edit
   end
  end

  def destroy
   @event = Event.find(params[:id])
   @event.destroy

   flash[:success] = 'タスクが削除されました'
   redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :content, :start_time)
  end

end