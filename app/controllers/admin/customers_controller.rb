class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all.page(params[:page])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customers_path
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to admin_customers_path
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :is_deleted, :profile_image)
  end

end
