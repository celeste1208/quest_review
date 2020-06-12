class UsersController < ApplicationController
  before_action :authenticate_owner
  before_action :set_user, only: [:show, :update]

  def show
  end
  
  def update
    @user.update(user_params)
  end

  private
  
    def authenticate_owner
      redirect_to root_path if current_user.id != params[:id].to_i
    end
  
    def set_user
      @user = User.find(params[:id]).decorate
    end
    
    def user_params
      params.require(:user).permit(:image)
    end
end
