class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  skip_before_filter :trial_expired?


  # GET /payments/new
  def new
    @payment = Payment.new
    @plan = params[:plan]
    @email = current_user.email
  end

  # POST /payments
  # POST /payments.json
  def create
    plan = params["payment"]["plan"]
    plan="premium_monthly" if plan.empty?
    stripe_token = params[:payment][:stripe_customer_token]
    cardHolderName = params["cardHolderName"]
    email = params["payment"]["email"]
    flag = false

    if stripe_token
      begin
        @payment = current_user.payments.new(payment_params)
        customer = current_user.do_transaction(params[:payment_type], stripe_token, plan, cardHolderName, email)
        if customer
          @payment.stripe_customer_token = customer.id
          subcripted_detail = customer.subscriptions["data"][0]
          flash[:notice] = 'Card charged successfully'
        else
          flag = true
          flash[:alert] = 'Some error happened while charging you, please double check your card details'
        end
      rescue Stripe::APIError => e
        flash[:alert] = e
        flag = true
      end
    else
      flag = true
      flash[:alert] = 'You did not submit the form correctly'
    end

    if flag
      render new_payment_path({plan: plan, error: e})
    end

    respond_to do |format|
      if @payment.save
        plan = Payment.plans[plan]
        current_user.update_attributes(subscription: plan, remaining_days: -1, stripe_customer_id: customer.id, is_paid_user: true)
        NotificationMailer.monthly_subscription_email(current_user, subcripted_detail).deliver_now
        format.html { redirect_to "/users/edit", notice: 'Payment made successfully.'}
        format.json { render json: @payment, status: :created, location: @payment }
      end
    end

  end

  def cancel_subscription_plan
    begin
      payments = current_user.payments.order("created_at desc")
      latest_payment = payments.first
      if latest_payment
        stripe_customer_id = latest_payment.stripe_customer_token
        delete_subscription = current_user.delete_subscription(stripe_customer_id)
        if delete_subscription
          status = delete_subscription["status"]
          if  status == "canceled"
            plan = User.subscriptions["cancelled"]
            latest_payment.update_attributes(plan: plan)
            current_user.update_attributes(subscription: plan, remaining_days: -1, stripe_customer_id: nil, is_paid_user: false)
            NotificationMailer.cancel_subscription_email(current_user).deliver_now
          end
        end
        flash[:info] = 'You canceled your subscription successfully'
      end
    rescue Stripe::APIError => e
      flash[:alert] = e

    rescue Exception => e
      flash[:alert] = e
    end
    redirect_to "/users/edit"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:stripe_customer_token, :user_id, :email, :plan)
    end
end
