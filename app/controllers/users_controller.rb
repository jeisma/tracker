class UsersController < ApplicationController
  def list
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Saved'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end
  
  def show
  end

  def edit
  end

  def change_password
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :last_name, :first_name)
  end  
end
