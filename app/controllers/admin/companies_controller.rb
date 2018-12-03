class Admin::CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /admin/companies
  # GET /admin/companies.json
  def index
    @companies = Company.includes(:company_type).order('updated_at DESC').page(params[:page]).per(10)
  end

  # GET /admin/companies/1
  # GET /admin/companies/1.json
  def show
  end

  # GET /admin/companies/new
  def new
    @company = Company.new
    @company.locations.build
    @company.phones.build
    @company.company_sectors.build
  end

  # GET /admin/companies/1/established_date
  def edit
  end

  # POST /admin/companies
  # POST /admin/companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      begin
        @company.save!
      rescue ActiveRecord::RecordInvalid => e
        if e.message == 'Validation failed: Email has already been taken'
          flash[:notice] = "Email has already been taken"
          format.html { render :action => 'new' }
        else
          format.html { render :action => 'new' }
        end
      end
      format.html { redirect_to admin_companies_url, notice: 'Company was successfully created.' }
    end
  end

  # PATCH/PUT /admin/companies/1
  # PATCH/PUT /admin/companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to admin_companies_url, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/companies/1
  # DELETE /admin/companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to admin_companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :employees_count, :established_date, :summary, :website, :revenue, :email, :hiring, :fund_raising, :company_type_id, locations_attributes: company_location_attrs, phones_attributes: company_phone_attrs, company_sectors_attributes: [:id, :sector_id, :_destroy])
    end

    def company_location_attrs
      [:id, :street, :state, :country, :city, :pin_code, :is_headquarter, :_destroy]
    end

    def company_phone_attrs
      [:id, :mobile, :fax, :landline, :_destroy]
    end
end
