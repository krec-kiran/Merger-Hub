class Admin::JobPortalsController < ApplicationController
  layout 'admin'

  def index
    conditions = {}
    conditions[:is_accept] = [false, nil]
    unless params[:geo].blank?
      @geo = params[:geo]
      conditions[:geo_id] = params[:geo]
    end
    unless params[:sector_name].blank?
      @sector_name = params[:sector_name]
      conditions[:sector_name] = params[:sector_name]
    end
    unless params[:location].blank?
      @location = params[:location]
      location = Location.where("LOWER(city) = ?","#{ params[:location].downcase }")
      conditions[:location_id] = location.pluck(:id)
    end
    @job_portals = JobPortal.includes(:location).where(conditions).page(params[:page]).per(5)
  end

  def show
    @job_portal = JobPortal.find(params[:id])
  end

  def approve_job
    job_portal = JobPortal.find(params[:id])
    job_portal.is_accept = params[:value]
    job_portal.save
    if params[:value] == "true"
      NotificationMailer.job_approve_emailto_user(current_user).deliver
    end
    head :ok
  end

end