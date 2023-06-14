class Public::NewsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @news_index = News.order('id DESC').page(params[:page])
  end

  def show
    @news = News.find(params[:id])
  end

end
