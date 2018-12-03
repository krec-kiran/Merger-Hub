class StaticPagesController < ApplicationController
  skip_before_filter :authenticate_user!, :trial_expired?

  def index
  end

  def price
  end

  def contact
  end

end