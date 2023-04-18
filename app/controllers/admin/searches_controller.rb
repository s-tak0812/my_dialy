class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @model = params[:model]
    @content = params[:content]

    if @model == 'customer'
      @results = Customer.search_for(@content).page(params[:page])
    end

  end

end
