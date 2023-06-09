class Public::BlogsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only:[:show, :edit, :update, :destroy]

  def index
    @blogs = current_customer.blogs
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_customer.blogs.new(blog_params)
    # Blogの文章をもとにAPIを通してscoreを生成
    @blog.score = Language.get_data(blog_params[:body])

    if @blog.save
      redirect_to blog_path(@blog.id)
    else
      render :new
    end

  end

  def edit
  end

  def update
    @blog.score = Language.get_data(blog_params[:body])

    if @blog.update(blog_params)
      redirect_to blog_path(@blog.id)
    else
      render :edit
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

  # 検索機能
  def search
    @customer = current_customer
    @content = params[:content]

    @results = Blog.search_for(@content, @customer).order('date DESC').page(params[:page])
  end


  private

  # 保存するパラメータ
  def blog_params
    params.require(:blog).permit(:title, :body, :date, :image)
  end

  # 投稿したcustomerでない場合topに返す
  def ensure_correct_customer
    @blog = Blog.find(params[:id])
    unless @blog.customer == current_customer
      redirect_to root_path
    end
  end

end
