class ContactsController < ApplicationController
  def new
    @contact_request = ContactRequest.new
  end

  def create
    @contact_request = ContactRequest.new(contact_request_params)

    if @contact_request.save
      # Optional: Send an email notification (if configured)
      # ContactMailer.contact_request(@contact_request).deliver_now

      redirect_to contact_path, notice: 'Thank you for reaching out! We will get back to you shortly.'
    else
      flash.now[:alert] = 'There was a problem with your submission. Please correct the errors and try again.'
      render :new
    end
  end

  private

  def contact_request_params
    params.require(:contact_request).permit(:name, :email, :subject, :message)
  end
end
