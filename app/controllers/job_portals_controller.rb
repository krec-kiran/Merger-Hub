class JobPortalsController < ApplicationController
  before_action :set_job_portal, only: [:show, :edit, :update, :destroy]

  # GET /job_portals
  # GET /job_portals.json
  def index
    conditions = {}
    conditions[:is_accept] = true
    unless params[:Geography].blank?
      @geo = params[:Geography]
      conditions[:geo_id] = params[:Geography]
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

  # GET /job_portals/1
  # GET /job_portals/1.json
  def show
  end

  # GET /job_portals/new
  def new
    @job_portal = JobPortal.new
    @job_portal.build_location
  end

  # GET /job_portals/1/edit
  def edit
  end

  # POST /job_portals
  # POST /job_portals.json
  def create
    @job_portal = JobPortal.new(job_portal_params)

    respond_to do |format|
      if @job_portal.save
        NotificationMailer.job_notification_email(current_user, request.base_url).deliver
        format.html { redirect_to job_portals_path, notice: 'Job created successfully. It  will be posted upon admin approval.' }
        format.json { render :show, status: :created, location: @job_portal }
      else
        format.html { render :new }
        format.json { render json: @job_portal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_portals/1
  # PATCH/PUT /job_portals/1.json
  def update
    respond_to do |format|
      if @job_portal.update(job_portal_params)
        format.html { redirect_to job_portals_path, notice: 'Job portal was successfully updated.' }
        format.json { render :show, status: :ok, location: @job_portal }
      else
        format.html { render :edit }
        format.json { render json: @job_portal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_portals/1
  # DELETE /job_portals/1.json
  def destroy
    @job_portal.destroy
    respond_to do |format|
      format.html { redirect_to job_portals_url, notice: 'Job portal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vacancies
    job_portals = JobPortal.accepted.includes(:location).order(id: :desc)
    render_json(true, job_portals, 200)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_portal
      @job_portal = JobPortal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_portal_params
      params.require(:job_portal).permit(:company_id, :website, :title, :sector_name, :geo_id, :summary, :requirement, :email, :posted_date, :location_id, :user_id, :is_accept, location_attributes: job_location_attrs)
    end

    def job_location_attrs
      [:id, :street, :state, :country, :city, :pin_code, :_destroy]
    end
end
