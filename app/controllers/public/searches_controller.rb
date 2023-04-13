class Public::SearchesController < ApplicationController

  def search
    @customer = current_customer
    @model = params[:model]
    @content = params[:content]

    if @model == 'blog'
      @results = Blog.search_for(@content, @customer).order('date DESC').page(params[:page])
    end


  end


end
