class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to customers_mypage_path
  end

  def drop
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を完了しました。"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :nickname, :email, :is_deleted)
  end

end
