class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer

    # 今日と明日のschedule表示
    @today_schedules = @customer.schedules.today_schedule
    @tomorrow_schedules = @customer.schedules.tomorrow_schedule

    # 今月の収支
    @current_month_spendings = @customer.household_budgets.current_month.spendings
    @current_month_incomes = @customer.household_budgets.current_month.incomes
    # 先月の収支
    @last_month_spendings = @customer.household_budgets.last_month.spendings
    @last_month_incomes = @customer.household_budgets.last_month.incomes


    life_cycles = current_customer.life_cycles.last_7_days

    data = life_cycles.group_by(&:title).map do |k, v|
      total_hours = v.sum { |lc| (lc.end_time.to_time - lc.start_time.to_time) / 3600 }
      [k, total_hours / v.map { |lc| lc.start_time.to_date }.uniq.size]
    end

    @chart_data_labels = data.map { |d| d[0] }
    @chart_data_sets = data.map { |d| d[1] }

  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_mypage_path
    else
      render :edit
    end
  end

  def drop
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を完了しました。"
    redirect_to root_path
  end

  def day_link
  end

  def memory
    @life_cycles = LifeCycle.where(date: Date.today) # 今日のデータのみ取得
    @start_times = @life_cycles.pluck(:start_time).map(&:to_s)
    @end_times = @life_cycles.pluck(:end_time).map(&:to_s)
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :is_deleted, :profile_image)
  end

end
