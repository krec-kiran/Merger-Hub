class CandidateMailer < ApplicationMailer
  default from: "mergerhub@gmail.com"

  def candidate_notification_email(candidate, base_url)
    @candidate = candidate
    @user = @candidate.user if @candidate
    @base_url = base_url
    mail(to: 'krec.kiran@gmail.com', subject: 'Mergerhub Accept User', :cc => ["prabud@spritle.com, thirumals@spritle.com, shanthi.a@spritle.com"])
  end

  def send_notification_to_user(user)
    @user = user
    mail(to: user.email, subject: 'Mergerhub Account Approved')
  end

end
