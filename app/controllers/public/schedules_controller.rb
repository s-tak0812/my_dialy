class Public::SchedulesController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only:[:edit, :update, :destroy]


  def the_day
  end


  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = current_customer.schedules.new(schedule_params)
    if @schedule.save
      redirect_to customers_mypage_path, notice: "You have created successfully."
    else
      render :new
    end

  end

  def edit
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to customers_mypage_path, notice: "You have updated successfully."
    else
      render "edit"
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to request.referer
  end


  private

  def schedule_params
    params.require(:schedule).permit(:title, :content, :start_time, :end_time, :date)
  end

  def ensure_correct_customer
    @schedule = Schedule.find(params[:id])
    unless @schedule.customer == current_customer
      redirect_to root_path
    end
  end

end
