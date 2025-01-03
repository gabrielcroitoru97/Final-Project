class ContactMailer < ApplicationMailer
  default from: 'contact@dinodesks.com'  # Replace with your domain or email

  def contact_request(name, email, message)
    @name = name
    @message = message

    mail(
      to: 'contact@dinodesks.com',  # Replace with the recipient email
      subject: "New Contact Request from #{@name}"
    )
  end
end
