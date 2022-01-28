class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]

  # GET /groups or /groups.json
  def index
    if session[:admin_id]
      @admin = Admin.find_by(id: session[:admin_id])
    end
    @groups = Group.all
  end

  # GET /groups/1 or /groups/1.json
  def show
    @group = Group.find(params[:id])
    @groupUsers = @group.users
  end

  # add a user to group page controller
  def add_user
    @users = User.all
    @group = Group.find_by(id: params[:gid])
    @groupUsers = @group.users
  end

  # creates a user to group pairing
  def create_grouping
    # render plain: params[:gid]
    @grouping = Grouping.new( {user_id: params[:uid], group_id: params[:gid]})
    @users = User.all
    @group = Group.find_by(id: params[:gid])
    @groupUsers = @group.users
    if @grouping.save
      render :add_user, notice: "Successfully added"
    else
      render :add_user
    end
  end
    
  # remove user from grouping to page.
  def remove_user
    @grouping = Grouping.find_by({user_id: params[:uid], group_id: params[:gid]})
    @grouping.destroy
    @users = User.all
    @group = Group.find_by(id: params[:gid])
    @groupUsers = @group.users
    flash[:success] = "The user was successfully removed from group."
    render :add_user
  end
  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: "Group was successfully updated." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def user_groups
    @user=User.find_by(id: session[:user_id])
    @Usergroup=@user.groups
  end

  def show_user_groups
    @group=Group.find_by(params[:id])
    @groupUsers=@group.users
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:name)
    end

   
    
end
