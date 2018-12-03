class RegistrationsController < Devise::RegistrationsController
  layout "application", except: [:new, :create]
  skip_before_filter :trial_expired?

  def create
    resource = build_resource(sign_up_params)
    if resource.save
      resource.temp_token = resource.confirmation_token
      resource.save
      flash[:notice] = "You have signed up successfully please confirm your email account."
      redirect_to "/candidates/new?temp_token=#{resource.temp_token}"
    else
      render 'new'
    end
  end

  def edit
    @payments = current_user.payments.order("created_at desc")
    @latest_payment = @payments.first
    if @latest_payment
      customer = current_user.stripe_customer(current_user.stripe_customer_id)
      @subscription_detail = current_user.subscription_detail(customer)
    else
      flash[:info] = "You don't currently have any active subscriptions!"
    end

  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :role_id, :email, :password, :password_confirmation, :subscription, :remaining_days)
  end

end