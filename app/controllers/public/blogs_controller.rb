class Public::BlogsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only:[:edit, :update, :destroy]

  def index
    @blogs = current_customer.blogs
    @household_budgets = current_customer.household_budgets
  end

  def new
    @blog = Blog.new
  end

  def create
    # 日付を取得
    date = params[:blog][:date]

    # current_customer が指定した日付にすでに投稿済みの場合はエラーとする
    if current_customer.blogs.exists?(date: date)
      redirect_to new_blog_path, alert: "You have already posted a blog today."
      return
    end

    @blog = current_customer.blogs.new(blog_params)
    if @blog.save
      redirect_to blog_path(@blog), notice: "You have created blog successfully."
    else
      render :new
    end

  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blog_path(@blog), notice: "You have updated blog successfully."
    else
      render "edit"
    end
  end

  def show
    @blog = Blog.find(params[:id])
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
