class Admin::NewsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @news_index = News.order('id DESC')
    @news_pagination = @news_index.page(20)
  end

  def show
    @news = News.find(params[:id])
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new(news_params)
    if @news.save
      redirect_to admin_news_path(@news.id)
    else
      render :new
    end
  end

  def edit
    @news = News.find(params[:id])
  end

  def update
    @news = News.find(params[:id])
    if @news.update(news_params)
      redirect_to admin_news_path(@news.id)
    else
      render :edit
    end
  end

  def destroy
    @news = News.find(params[:id])
    @news.destroy
    redirect_to admin_news_index_path
  end

  private

  def news_params
    params.require(:news).permit(:title, :content)
  end

end
