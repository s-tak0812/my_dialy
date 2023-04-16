class Public::SchedulesController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only:[:edit, :update, :destroy]

  def index
    @schedules = current_customer.schedules
    @schedule = Schedule.new
  end


  def create
    @schedule = current_customer.schedules.new(schedule_params)
    if @schedule.save
      redirect_to schedules_path
    else
      @schedules = current_customer.schedules.select(&:persisted?)
      render :index
    end

  end

  def edit
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to schedules_path
    else
      render :edit
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to schedules_path
  end


  private

  def schedule_params
    params.require(:schedule).permit(:title, :content, :start_time, :end_time)
  end

  def ensure_correct_customer
    @schedule = Schedule.find(params[:id])
    unless @schedule.customer == current_customer
      redirect_to root_path
    end
  end

end
