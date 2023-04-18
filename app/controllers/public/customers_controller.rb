class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_test_customer, only:[:edit, :update, :drop]

  def show
    @customer = current_customer

    # schedule
    # 今日と明日のschedule表示
    @today_schedules = @customer.schedules.today_schedule
    @tomorrow_schedules = @customer.schedules.tomorrow_schedule

    # household_hold
    # 今月の収支
    @current_month_spendings = @customer.household_budgets.current_month.spendings
    @current_month_incomes = @customer.household_budgets.current_month.incomes
    # 先月の収支
    @last_month_spendings = @customer.household_budgets.last_month.spendings
    @last_month_incomes = @customer.household_budgets.last_month.incomes


    # life_cycle
    # 直近1週間のlife_cycleのデータ取得
    life_cycles = current_customer.life_cycles.last_7_days
    # title別で１日平均を求める
    # 直近1週間の内に投稿されたデータをtitle別で合計し
    # title別で投稿されている日数(同日に同titleで複数投稿があった場合も”1”とする)で割る
    data = life_cycles.group_by(&:title).map do |k, v|
      total_hours = v.sum { |lc| (lc.end_time.to_time - lc.start_time.to_time) / 3600 }
      [k, total_hours / v.map { |lc| lc.start_time.to_date }.uniq.size]
    end
    # chartのlabel(title)
    @chart_data_labels = data.map { |d| d[0] }
    # chartのデータ(x.xx時間)
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

  # 退会機能
  def drop
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  # 保存するパラメータ
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :is_deleted, :profile_image)
  end

  # お試し用アカウントの制限
  def ensure_test_customer
    if current_customer.email == 'test@hoge.com'
      redirect_to root_path, alert: 'お試しではその操作はできません'
    end
  end

end
