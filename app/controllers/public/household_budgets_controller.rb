class Public::HouseholdBudgetsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only:[:edit, :update, :destroy]

  def index
    @spendings = current_customer.household_budgets.spendings
    @incomes = current_customer.household_budgets.incomes

    @household_budget = HouseholdBudget.new
  end

  def create
    @household_budget = current_customer.household_budgets.new(household_budget_params)
    if @household_budget.save
      redirect_to household_budgets_path
    else
      @spendings = current_customer.household_budgets.spendings
      @incomes = current_customer.household_budgets.incomes
      render :index
    end

  end

  def edit
  end

  def update
    if @household_budget.update(household_budget_params)
      redirect_to household_budgets_path
    else
      render :edit
    end
  end

  def destroy
    @household_budget = HouseholdBudget.find(params[:id])
    @household_budget.destroy
    redirect_to request.referer
  end

  # 日付の絞り込み検索
  def date_show
    @day_params = params[:date]
    @household_budgets = current_customer.household_budgets.where(date: @day_params).order('price DESC')
  end

  # 期間の絞り込み検索
  def day_to_day
    @from = params[:from]
    @to = params[:to]
    @household_budgets = current_customer.household_budgets.where('date BETWEEN ? AND ?', @from, @to).order('price DESC')
    @spendings = @household_budgets.spendings
    @incomes = @household_budgets.incomes
  end

  def days_sort
    @from = params[:from]
    @to = params[:to]
    household_budgets = current_customer.household_budgets.where('date BETWEEN ? AND ?', @from, @to).order('price DESC')

    @sort = params[:sort]

    if @sort == "tax"
      @sort_title = "税金"
      @household_budgets = household_budgets.tax_order
    elsif @sort == "food_and_drink"
      @sort_title = "飲食"
      @household_budgets = household_budgets.food_and_drink_order
    elsif @sort == "entertainment"
      @sort_title = "娯楽"
      @household_budgets = household_budgets.entertainment_order
    elsif @sort == "utility_costs"
      @sort_title = "光熱費"
      @household_budgets = household_budgets.utility_costs_order
    elsif @sort == "income"
      @sort_title = "収入"
      @household_budgets = household_budgets.income_order
    else
      @sort_title = "その他"
      @household_budgets = household_budgets.others_order
    end

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
