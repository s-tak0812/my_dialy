class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    @customer = current_customer
  end


end
