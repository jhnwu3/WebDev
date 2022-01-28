class SessionsController < ApplicationController

  def new 

  end

  def create
    # login page to find if the email is an admin. authentication of admins happen here.
    admin = Admin.find_by(email: params[:email])
    if admin.present? && admin.authenticate(params[:password]) # use a hash
      session[:admin_id] = admin.id
      redirect_to admin_home_path, notice: "Logged in as admin successfully"
    else
      # check if email is a normal user to log in
      user = User.find_by(email: params[:email])
      if user.present? && user.password == params[:password] 
        session[:user_id] = user.id
        redirect_to user_home_path, notice: "Logged in successfully"
        # deny login otherwise.
      else
        flash[:alert] = "Invalid email or password"
        render :new
      end
    end
  end
  

  def destroy 
    session[:admin_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end
