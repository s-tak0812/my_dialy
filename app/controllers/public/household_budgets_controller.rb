class Public::HouseholdBudgetsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only:[:edit, :update, :destroy]


  def new
    @household_budget = HouseholdBudget.new
  end

  def create
    @household_budget = current_customer.household_budgets.new(household_budget_params)
    if @household_budget.save
      redirect_to customers_mypage_path, notice: "You have created successfully."
    else
      render :new
    end

  end

  def edit
  end

  def update
    if @household_budget.update(household_budget_params)
      redirect_to customers_mypage_path, notice: "You have updated blog successfully."
    else
      render "edit"
    end
  end

  def destroy
    @household_budget = HouseholdBudget.find(params[:id])
    @household_budget.destroy
    redirect_to request.referer
  end


  private

  def household_budget_params
    params.require(:household_budget).permit(:title, :price, :is_active, :date)
  end

  def ensure_correct_customer
    @household_budget = HouseholdBudget.find(params[:id])
    unless @household_budget.customer == current_customer
      redirect_to root_path
    end
  end

end
