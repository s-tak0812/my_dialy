class Public::LifeCyclesController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only:[:edit, :update, :destroy]

  def index
    @life_cycles = current_customer.life_cycles
    # 新規投稿時のエラーを返すため
    @life_cycle = LifeCycle.new
  end

  def create
    @life_cycle = current_customer.life_cycles.new(life_cycle_params)
    if @life_cycle.save
      redirect_to life_cycles_date_show_path(@life_cycle.start_time.to_date)
    else
      # indexに遷移させるため
      @life_cycles = current_customer.life_cycles
      render :index
    end
  end

  def edit
  end

  def update
    if @life_cycle.update(life_cycle_params)
      redirect_to life_cycles_date_show_path(@life_cycle.start_time.to_date)
    else
      render :edit
    end
  end

  def destroy
    @life_cycle = LifeCycle.find(params[:id])
    @life_cycle.destroy
    redirect_to request.referer
  end

  # 日付の絞り込み検索
  def date_show
    # params[:date]をconfig.time_zoneに合わせる
    @day_params = Time.zone.parse(params[:date])
    @life_cycles = current_customer.life_cycles.where(start_time: @day_params.all_day).order('start_time ASC')
    @life_cycle = LifeCycle.new

    # [ title , 実行時間(H) ]に変換
    data = @life_cycles.map{ |lc| [lc.title, ((lc.end_time - lc.start_time)/60)/60] }
    # chartのlabel(title)
    @chart_data_labels = data.map { |d| d[0] }
    # chartのデータ(実行時間)
    @chart_data_sets = data.map { |d| d[1] }
  end


  private

  # 保存するパラメータ
  def life_cycle_params
    params.require(:life_cycle).permit(:title, :start_time, :end_time)
  end

  # 投稿したcustomerでない場合topに返す
  def ensure_correct_customer
    @life_cycle = LifeCycle.find(params[:id])
    unless @life_cycle.customer == current_customer
      redirect_to root_path
    end
  end

end
