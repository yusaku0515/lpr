class ContactsController < ApplicationController
def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver_now
      flash[:success] = 'お問い合わせを受け付けました'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def contact_params
    params.permit(:email, :message) #require(:contact)は不要
  end
end
