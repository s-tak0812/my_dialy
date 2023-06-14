class Public::NewsController < ApplicationController


  def index
    @news_index = News.order('id DESC')
    @news_pagination = @news_index.page(20)
  end

  def show
    @news = News.find(params[:id])
  end

end
