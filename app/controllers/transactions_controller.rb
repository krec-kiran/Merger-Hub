class TransactionsController < ApplicationController
  layout :false, only: [:transaction_filters, :transaction_list, :recent_deals]

  def index
  end

  def new
    @transaction = MaTransaction.new
    @transaction.investors.build
  end

  def create
    @transaction = MaTransaction.new(transaction_params)
    candidate_url = "/candidates#/" + params[:person_id] + "/detail"
    respond_to do |format|
      if params[:ma_transaction][:company_id] && @transaction.save
        @transaction.is_approve = false
        @transaction.save
        TransactionMailer.transaction_email_to_admin(@transaction, request.base_url, current_user.full_name).deliver
        format.html { redirect_to candidate_url, notice: 'Transaction created successfully  it will be visible upon admin approval' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def transaction_filters
    @success = true
    @companies = Company.order("name")
    @sectors = Sector.order("name")
    @transaction_years = MaTransaction.order(date: :asc).map{ |d| d.date.strftime("%Y") if d.date }.uniq
  end

  def transaction_list
    company_id = params["company_id"]
    sector_id = params["sector_id"]
    fromYear = params["from_year"]
    toYear = params["to_year"]

    company_id = Company.pluck(:id) if company_id.blank?
    sector_id = Sector.pluck(:id) if sector_id.blank?

    # @transaction = MaTransaction.searchDeals(company_id, sector_id, fromYear, toYear)
    @transaction = MaTransaction.approved.searchTransaction(company_id, sector_id, fromYear, toYear)
    transaction_investor(@transaction)

    company_ids = @transaction.pluck(:target_id)
    @advisors = Advisor.includes(:company).where(company_id: company_ids)
    @success = @transaction ? true : false
  end

  def transaction_investor transactions
    @buyer = transactions.all.map do |transaction|
      transaction.investors.map do |investor|
        investor.buyer
      end
    end
    @seller = transactions.all.map do |transaction|
      transaction.investors.map do |investor|
        investor.seller
      end
    end
    companies = @buyer.uniq.flatten.compact + @seller.uniq.flatten.compact
    @firms = []
    @companies = []
    companies.each do |company|
      if company.company_type.name == "PE Firm"
        @firms << company
      elsif company.company_type.name == "Company"
        @companies << company
      end
    end
  end

  def recent_deals
    current_month = Date.today.month
    last_month = Date.today.month - 1
    current_year = Date.today.year
    @transactions = MaTransaction.joins(:transaction_type, :investors => [:buyer, :seller]).select("DISTINCT(target_id), date, target_id, transaction_type_id, value, seller_id, buyer_id").where("extract(month from date) between ? and ? and extract(year from date) = ?", last_month, current_month, current_year).group("target_id, date, target_id, transaction_type_id, value, seller_id, buyer_id")

    @success = @transactions ? true : false
  end

  def edit
    @transaction = MaTransaction.find(params[:id])
  end

  def update
    @transaction = MaTransaction.find(params[:id])
    candidate_url = "/candidates#/" + params[:person_id] + "/detail"
    respond_to do |format|

      if @transaction.update(transaction_params)
        @transaction.is_approve = false
        @transaction.save
        TransactionMailer.transaction_email_to_admin(@transaction, request.base_url, current_user.full_name).deliver
        format.html { redirect_to candidate_url, notice: 'Your changes for the transaction will be visible upon admin approval' }
        format.json { render :show, status: :ok, location: @job_portal }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:ma_transaction).permit(:company_id, :date, :target_id, :transaction_type_id, :value, investors_attributes: investors_attrs)
    end

    def investors_attrs
      [:id, :buyer_id, :seller_id, :_destroy]
    end

end
