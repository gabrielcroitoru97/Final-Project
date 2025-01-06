class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      # Optional: Send an email notification (if configured)
      # ContactMailer.contact_request(@contact).deliver_now

      redirect_to new_contact_path, notice: 'Thank you for reaching out! We will get back to you shortly.'
    else
      flash.now[:alert] = 'There was a problem with your submission. Please correct the errors and try again.'
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
