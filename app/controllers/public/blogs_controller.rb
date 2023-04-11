class Public::BlogsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only:[:edit, :update, :destroy]

  def index
    @blogs = current_customer.blogs
    @household_budgets = current_customer.household_budgets
    @life_cycles = current_customer.life_cycles
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_customer.blogs.new(blog_params)
    if @blog.save
      redirect_to blog_path(@blog), notice: "投稿完了！"
    else
      render :new
    end

  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blog_path(@blog), notice: "更新完了！"
    else
      render :edit
    end
  end

  def show
    @params = params[:date]
    @blog = Blog.find_by(date: params[:date])
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path
  end


  private

  def blog_params
    params.require(:blog).permit(:title, :body, :date, :image)
  end

  def ensure_correct_customer
    @blog = Blog.find(params[:id])
    unless @blog.customer == current_customer
      redirect_to root_path
    end
  end

end
