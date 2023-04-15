class Public::LifeCyclesController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only:[:edit, :update, :destroy]

  def index
    @life_cycles = current_customer.life_cycles

  end

  def new
    @life_cycle = LifeCycle.new
  end

  def create
    @life_cycle = current_customer.life_cycles.new(life_cycle_params)
    if @life_cycle.save
      redirect_to request.referer
    else
      render :new
    end

  end

  def edit
  end

  def update
    if @life_cycle.update(life_cycle_params)
      redirect_to life_cycles_date_show_path(@life_cycle.date)
    else
      render :edit
    end
  end

  def destroy
    @life_cycle = LifeCycle.find(params[:id])
    @life_cycle.destroy
    redirect_to request.referer
  end

  def date_show
    @day_params = params[:date]
    @life_cycles = current_customer.life_cycles.where(date: @day_params).sort_by { |lc| lc.start_time.strftime('%H') }
    @life_cycle = LifeCycle.new

    data = @life_cycles.map{ |lc| [lc.title, ((lc.end_time - lc.start_time)/60)/60] }
    @chart_data_labels = data.map { |d| d[0] }
    @chart_data_sets = data.map { |d| d[1] }

  end


  private

  def life_cycle_params
    params.require(:life_cycle).permit(:title, :start_time, :end_time, :date)
  end

  def ensure_correct_customer
    @life_cycle = LifeCycle.find(params[:id])
    unless @life_cycle.customer == current_customer
      redirect_to root_path
    end
  end

end
