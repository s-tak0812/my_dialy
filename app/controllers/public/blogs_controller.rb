class Public::BlogsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only:[:edit, :update, :destroy]

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.customer_id = current_customer.id
    if @blog.save
      @effective_date = EffectiveDate.new(effective_date_params)
      @effective_date.customer_id = current_customer.id
      @effective_date.blog_id = @blog.id
      @effective_date.active_date = params[:active_date]

      @effective_date.save
      redirect_to blog_path(@blog), notice: "You have created book successfully."
    else
      redirect_to customers_mypage_path
    end
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blog_path(@blog), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def destroy
    @blog.destroy
    redirect_to root_path
  end


  private

  def blog_params
    params.require(:blog).permit(:title, :body, :image)
  end

  def effective_date_params
    params.require(:effective_date).permit(:active_date, :customer_id, :blog_id)
  end

  def ensure_correct_customer
    @blog = Blog.find(params[:id])
    unless @blog.customer == current_customer
      redirect_to root_path
    end
  end

end
