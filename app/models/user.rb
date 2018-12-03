class User < ActiveRecord::Base
  include Stripe::Callbacks
  belongs_to :role
  has_many :payments
  has_one :candidate
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :email, uniqueness: true
  validates :first_name, :last_name, presence: true

  devise :database_authenticatable, :async, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  delegate :name, to: :role, allow_nil: true, prefix: :role

  enum subscription: {"trial" => 0, "paid" => 1, "cancelled" => 2}

  def full_name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  def stripe_customer(stripe_customer_id)
    Stripe::Customer.retrieve(stripe_customer_id)
  end

  def confirmed?
    !!confirmed_at && self.is_accept == true
  end

  def do_transaction(type, stripe_token, plan, cardHolderName, email)
    customer = Stripe::Customer.create(
      :card => stripe_token,
      :plan => plan,
      :description => cardHolderName + " charged for the plan " + plan,
      :email => email
    )
  end

  def delete_subscription(stripe_customer_id)
    customer = stripe_customer(stripe_customer_id)
    subscription_detail = subscription_detail(customer)
    if subscription_detail
      subscription_id = subscription_detail.id
      customer.subscriptions.retrieve(subscription_id).delete
    end
  end

  def subscription_detail(customer)
    data = customer.subscriptions["data"]
    if !data.empty?
      subscription_detail = data[0]
    end
    return subscription_detail
  end

end
