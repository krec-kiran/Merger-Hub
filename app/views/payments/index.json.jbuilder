json.array!(@payments) do |payment|
  json.extract! payment, :id, :stripe_customer_token, :user_id, :email, :plan
  json.url payment_url(payment, format: :json)
end
