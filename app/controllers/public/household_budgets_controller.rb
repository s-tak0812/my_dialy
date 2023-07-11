class Public::HouseholdBudgetsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only:[:edit, :update, :destroy]

  def index
    # customerの支出一覧(is_active: false)
    @spendings = current_customer.household_budgets.spendings
    # customerの収入一覧(is_active: true)
    @incomes = current_customer.household_budgets.incomes

    @household_budget = HouseholdBudget.new
  end

  def create
    @household_budget = current_customer.household_budgets.new(household_budget_params)
    if @household_budget.save
      redirect_to household_budgets_date_show_path(@household_budget.date)
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
      redirect_to household_budgets_date_show_path(@household_budget.date)
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

    @household_budget = HouseholdBudget.new
  end

  # 期間の絞り込み検索
  def day_to_day
    # 期間の開始日
    @from = params[:from]
    # 期間の終了日
    @to = params[:to]

    @household_budgets = current_customer.household_budgets.where('date BETWEEN ? AND ?', @from, @to).order('price DESC')
    @spendings = @household_budgets.spendings
    @incomes = @household_budgets.incomes
    # Kaminari用
    @household_budgets_pagination = @household_budgets.page(params[:page])
  end

  # 期間の絞り込みからtitle別でソートする
  def days_sort
    @from = params[:from]
    @to = params[:to]
    household_budgets = current_customer.household_budgets.where('date BETWEEN ? AND ?', @from, @to).order('price DESC')

    # 絞り込みたいtitleを受け取る
    @sort = params[:sort]

    # 項目の日本語表記
    @sort_title = HouseholdBudget.sort_title_ja(@sort)
    # 項目での絞込検索
    @household_budgets = household_budgets.sort_by_title(@sort)

    # Kaminari用
    @household_budgets_pagination = @household_budgets.page(params[:page])

  end

  # 日にち検索
  def search
    day_params = params[:date]
    result = HouseholdBudget.search_for(day_params)
    # formから受け取った値からdate_showに遷移する
    redirect_to household_budgets_date_show_path(day_params)
  end

  private

  # 保存するパラメータ
  def household_budget_params
    params.require(:household_budget).permit(:title, :price, :is_active, :date)
  end

  # 投稿したcustomerでない場合topに返す
  def ensure_correct_customer
    @household_budget = HouseholdBudget.find(params[:id])
    unless @household_budget.customer == current_customer
      redirect_to root_path
    end
  end

end
