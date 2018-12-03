class Admin::SectorsController < ApplicationController
  before_action :set_sector, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  def index
    @sectors = Sector.order('updated_at DESC').page(params[:page]).per(10)
  end

  def show
  end

  def new
    @sector = Sector.new
  end

  def edit
  end


  def create
    @sector = Sector.new(sector_params)

    respond_to do |format|
      if @sector.save
        format.html { redirect_to admin_sectors_url, notice: 'Sector was successfully created.' }
        format.json { render :show, status: :created, location: @sector }
      else
        format.html { render :new }
        format.json { render json: @sector.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @sector.update(sector_params)
        format.html { redirect_to admin_sectors_url, notice: 'Sector was successfully updated.' }
        format.json { render :show, status: :ok, location: @sector }
      else
        format.html { render :edit }
        format.json { render json: @sector.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sector.destroy
    respond_to do |format|
      format.html { redirect_to admin_sectors_url, notice: 'Sector was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_sector
      @sector = Sector.find(params[:id])
    end

    def sector_params
      params.require(:sector).permit(:name)
    end
end