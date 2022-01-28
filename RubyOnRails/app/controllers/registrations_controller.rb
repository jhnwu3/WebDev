class RegistrationsController < ApplicationController

    # used to generate new admins.
    def new
        @admin = Admin.new
    end

    # for signup pages
    def create
        @admin = Admin.new(user_params)
        if @admin.save 
            session[:admin_id] = @admin.id
            redirect_to admin_home_path, notice: "Successfully created account"
        else
            render :new
        end
    end

    def  user_params
        params.require(:admin).permit(:name, :email, :password, :password_confirmation)
    end
    
end
