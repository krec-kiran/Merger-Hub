class TransactionMailer < ApplicationMailer
  default from: "mergerhub@gmail.com"

  def transaction_email_to_admin(transaction, base_url, user_name)
    @transaction = transaction
    @base_url = base_url
    @user_name = user_name
    mail(to: 'krec.kiran@gmail.com', subject: 'Mergerhub Approve Transaction Update', :cc => ["prabud@spritle.com, thirumals@spritle.com, shanthi.a@spritle.com"])
  end

  def approve_transaction_emailto_user(transaction)
    @transaction = transaction
    email = transaction.company.candidates.first.email if transaction.company.candidates
    mail(to: email, subject: 'Mergerhub Approved Transaction')
  end

end