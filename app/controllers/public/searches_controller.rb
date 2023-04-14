class Public::SearchesController < ApplicationController

  def search
    @customer = current_customer
  end


end
