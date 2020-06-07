ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :family_name, :first_name, :icon_image_id, :age, :introduction, :postal_code, :company_name, :address, :phone_number, :hp_url, :user_status
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :family_name, :first_name, :icon_image_id, :age, :introduction, :postal_code, :company_name, :address, :phone_number, :hp_url, :user_status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
