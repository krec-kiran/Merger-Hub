class Admin::TransactionsController < ApplicationController
  layout 'admin'

  def edit
  end

  def index
    @transactions = MaTransaction.not_approved.includes(:target, :company, :investors, :transaction_type).order('updated_at DESC').page(params[:page]).per(10)
  end

  def approve_transaction
    transaction = MaTransaction.find(params[:id])
    transaction.is_approve = params[:value]
    transaction.approved_by = current_user.full_name if current_user
    transaction.save
    if params[:value] == "true"
      TransactionMailer.approve_transaction_emailto_user(transaction).deliver
    end
    head :ok
  end

end
