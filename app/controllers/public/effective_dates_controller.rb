class Public::EffectiveDatesController < ApplicationController
  def index
    @effective_dates = EffectiveDate.all
  end

  def show
  end
end
