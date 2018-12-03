class NotificationMailer < ApplicationMailer
  default from: "mergerhub@gmail.com"

  def job_notification_email(user, base_url)
    @user_name = "#{ user.first_name } #{ user.last_name }"
    @base_url = base_url
    mail(to: 'krec.kiran@gmail.com', subject: 'Mergerhub Accept Job', :cc => ["prabud@spritle.com, thirumals@spritle.com, shanthi.a@spritle.com"])
  end

  def job_approve_emailto_user(user)
    @user_name = "#{ user.first_name } #{ user.last_name }"
    mail(to: user.email, subject: 'Mergerhub Accept Job')
  end

  def monthly_subscription_email(user, subcripted_detail)
    @user_name = user.full_name
    subject = "Your Mergerhub subscription"
    @subcripted_detail = subcripted_detail
    cc = "prabud@spritle.com"
    mail(to: user.email, subject: subject, cc: cc)
  end

  def cancel_subscription_email(user)
    @user_name = user.full_name
    subject = "Your Mergerhub - Subscription Canceled"
    cc = "prabud@spritle.com"
    mail(to: user.email, subject: subject, cc: cc)
  end

end
