class Admin::SearchesController < ApplicationController

  def search
    @model = params[:model]
    @content = params[:content]

    if @model == 'customer'
      @results = Customer.search_for(@content).page(params[:page])
    end

  end

end
