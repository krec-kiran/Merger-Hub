class DashboardController < ApplicationController
  before_filter :trial_expired?
  def index
  end
end
