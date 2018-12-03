class Admin::CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]
  layout false, only: [:approve_user, :upload_avatar, :get_avatar, :delete_avatar]
  layout 'admin'

  def index
    @candidates = Candidate.includes(:user, :company => (:sectors)).order('updated_at DESC').page(params[:page]).per(10)
  end

  def show
  end

  def new
    @candidate = Candidate.new
  end

  def edit
  end


  def create
    @candidate = Candidate.new(candidate_params)

    respond_to do |format|
      if @candidate.save
        format.html { redirect_to admin_candidates_url, notice: 'Candidate was successfully created.' }
        format.json { render :show, status: :created, location: @candidate }
      else
        flash[:notice] = "Email already exists"
        format.html { render :new }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @candidate.update(candidate_params)
        format.html { redirect_to admin_candidates_url, notice: 'Candidate was successfully updated.' }
        candidate = candidate_json(@candidate)
        format.json { render_json(true, candidate , 200)}
      else
        format.html { render :edit }
        format.json { render_json(false, @candidate.errors , :unprocessable_entity)}
      end
    end
  end

  def destroy
    @candidate.destroy
    respond_to do |format|
      format.html { redirect_to admin_candidates_url, notice: 'Candidate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_avatar
    candidate = Candidate.find(params[:id])
    respond_with candidate do |format|
      format.json { render json: candidate.to_json(:methods => [:avatar_medium_url, :avatar_thumb_url]) }
    end
  end

  def delete_avatar
    candidate = Candidate.find(params[:id])
    candidate.avatar = nil
    candidate.save
    render_json(true, candidate.to_json(:methods => [:avatar_medium_url, :avatar_thumb_url]) , 200)
  end

  def approve_user
    if params[:id].present?
      user = User.find(params[:id])
      user.is_accept = params[:value]
      user.save
      if user.is_accept == true
        CandidateMailer.send_notification_to_user(user).deliver
      end
      head :ok
    end
  end

  def upload_avatar
    candidate = Candidate.update(params[:id], candidate_params)
    if candidate
      error_message =  candidate.errors.full_messages
      if error_message && !error_message.blank?
        render_json(false, {message: "candidate avatar upload failed try again! \n " + error_message.join(", ") } , 500)
      else
        render_json(true, candidate.to_json(:methods => [:avatar_medium_url, :avatar_thumb_url]), 200)
      end
    else
      render_json(false, {message: "candidate avatar upload failed."} , 500)
    end
  end

  def candidate_json(candidate)
    {
      id: candidate.id,
      name: candidate.name,
      email: candidate.email,
      company_name: candidate.company_name,
      sector_name: candidate.company.sectors.pluck(:name).join(","),
      joined: candidate.joined,
      designation: candidate.designation,
      bio: candidate.bio,
      work_history: candidate.work_history,
      industry_specialty: candidate.industry_specialty,
      board_member: candidate.board_member,
      education: candidate.education,
      phone: candidate.phone,
      skills: candidate.skills,
      language: candidate.language,
      location: candidate.full_address,
      editable: candidate.is_editable?(current_user),
      avatar: candidate.avatar.url(:medium)
    }
  end

  private

    def set_candidate
      @candidate = Candidate.find(params[:id])
      @candidate.is_editable?(current_user)
    end

    def candidate_params
      params.require(:candidate).permit(:id, :name, :email, :city, :language, :year, :company_id, :designation, :joined, :bio, :work_history, :industry_specialty, :board_member, :education, :phone, :avatar, :street, :state, :country, :pin_code, :skills)
    end

end