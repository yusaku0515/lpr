class ContactsController < ApplicationController
  def new
    @contact = Contact.new
    end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      flash[:success] = 'お問い合わせを受け付けました'
      redirect_to root_path
    else
      redirect_to contacts_new_path, notice: "メールアドレスとお問い合わせ内容に空欄があると送信できません"
    end
  end

  private

  def contact_params
    params.permit(:email, :message) # require(:contact)は不要
  end
end
