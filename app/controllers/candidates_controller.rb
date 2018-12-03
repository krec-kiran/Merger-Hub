class CandidatesController < ApplicationController
  layout :false, only: [:people_filters, :people_list, :people_detail]
  before_filter :trial_expired?, except: [:new, :create]
  before_action :authenticate_user!, except: [:new, :create]

  def new
    @candidate = Candidate.new
    @user = User.find_by(temp_token: params[:temp_token]) if params[:temp_token]
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if params[:candidate][:company_id].present?
      candidate_create_method(@candidate)
    else
      if params[:sector].present? && params[:company_name].present? && params[:company_type].present? && params[:website].present? && params[:city].present? && params[:country].present? && params[:landline]
        company = Company.find_or_create_by(name: params[:company_name], company_type_id: params[:company_type], website: params[:website])
        location = company.locations.create(city: params[:city], country: params[:country]) if company
        phone = company.phones.create(landline: params[:landline]) if company
        company_sector = CompanySector.create(company_id: company.id, sector_id: params[:sector]) if company
        @candidate[:company_id] = company.id if company
      end
      candidate_create_method(@candidate)
    end
  end

  def candidate_create_method(candidate)
    respond_to do |format|
      if candidate[:company_id].present? && candidate.save
        if candidate.user
          candidate.user.temp_token = nil if candidate.user
          candidate.user.save
        end

        CandidateMailer.candidate_notification_email(candidate, request.base_url).deliver
        format.html { redirect_to "/users/sign_in", notice: 'Candidate was successfully created. You will be receiving approval mail from admin for accessing your account.' }
        format.json { render :show, status: :created, location: candidate }
      else
        flash[:warning] = "Company information is required."
        format.html { render :new }
        format.json { render json: candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
  end

  def people_filters
    @success = true
    @candidates = Candidate.order("name")
    @sectors = Sector.order("name")
    @companies = Company.order("name")
    cities = Candidate.pluck("LOWER(city)").uniq.compact
    @cities = cities.map{ |i| i.titleize if i.present? }
  end

  def people_list
    candidate_id = params["candidate_id"]
    company_id = params["company_id"]
    sector_id = params["sector_id"]
    title = params["title"]
    city = params["city"].downcase  if params["city"].present?
    candidate_id = Candidate.pluck(:id) if candidate_id.blank?
    company_id = Company.pluck(:id) if company_id.blank?
    sector_id = Sector.pluck(:id) if sector_id.blank?
    city = Candidate.pluck("LOWER(city)").uniq if city.blank?
    @people = Candidate.searchCandidate(candidate_id, company_id, sector_id, title, city)
    @success = @people ? true : false
  end

  def people_detail
    member_id = params["id"]
    @person = Candidate.find(member_id)
    @person.is_editable?(current_user)
    @success = @person ? true : false
  end

  def candidate_params
    params.require(:candidate).permit(:id, :name, :email, :city, :language, :year, :company_id, :designation, :joined, :bio, :work_history, :industry_specialty, :board_member, :education, :phone, :avatar, :street, :state, :country, :pin_code, :skills, :user_id)
  end

end
