class AdminController < ApplicationController

  # initial index admin home page controller
  def index
    if session[:admin_id]
      @admin = Admin.find_by(id: session[:admin_id])
    end
  end



  # below were preliminary functions that can ignore. They were how we learned how to MVC ruby on rails, please don't consider this part for grading.
  def index_group
    @groups = Group.all
    if session[:admin_id]
      @admin = Admin.find_by(id: session[:admin_id])
    end
  end

  def index_project
    if session[:admin_id]
      @admin = Admin.find_by(id: session[:admin_id])
    end
  end

  def new_group
      @groups = Group.all
      @group= Group.new
  end

  def create_group
      if session[:admin_id]
        @admin = Admin.find_by(id: session[:admin_id])
      end

      @group = Group.new(group_params)
      if @group.save 
          redirect_to group_home_url, notice: "Successfully created group"
      else
          render :new_group
      end
  end

  def destroy
      @group = Group.find(params[:id])
      @group.destroy
      flash[:success] = "The group was successfully destroyed."
      redirect_to group_home_url
  end

  def  group_params
      params.require(:group).permit(:groupname)
  end

  
  def new_proj
        @projects= Project.new
  end

  def create_proj
      if session[:admin_id]
        @admin = Admin.find_by(id: session[:admin_id])
      end
      @projects = Project.new(projects_params)
      if @projects.save 
          redirect_to root_path, notice: "Successfully created project"
      else
        render :new_proj
      end
  end

  def projects_params
    params.require(:project).permit(:projectname, :projecttype, :deadline, :commit)
  end

  

end
