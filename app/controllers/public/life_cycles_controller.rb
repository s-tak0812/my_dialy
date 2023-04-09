class Public::LifeCyclesController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only:[:edit, :update, :destroy]

  def new
    @life_cycle = LifeCycle.new
  end

  def create
    @life_cycle = current_customer.life_cycles.new(life_cycle_params)
    if @life_cycle.save
      redirect_to customers_mypage_path, notice: "You have created successfully."
    else
      render :new
    end

  end

  def edit
  end

  def update
    if @life_cycle.update(life_cycle_params)
      redirect_to customers_mypage_path, notice: "You have updated successfully."
    else
      render "edit"
    end
  end

  def destroy
    @life_cycle = LifeCycle.find(params[:id])
    @life_cycle.destroy
    redirect_to request.referer
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
