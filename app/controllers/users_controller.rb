class UsersController < ApplicationController



	def index
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
		   redirect_to user_path(@user.id)
        else
           render 'edit'
        end
	end


	def leave
	end

private
    def user_params
    	    params.require(:user).permit(:family_name, :first_name, :icon_image, :introduction, :postal_code, :company_name, :address, :phone_mamber, :hp_url)
    end
end
