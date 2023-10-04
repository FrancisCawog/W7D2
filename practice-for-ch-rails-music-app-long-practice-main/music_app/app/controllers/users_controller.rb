class UsersController < ApplicationController
    before_action :require_logged_in, only:[:destroy, :index, :show]
    before_action :require_logged_out, only:[:new, :create]

    def index
        @users = User.all
    end

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            login(@user)
            redirect_to user_url(@user)
        else
            @user = User.new(email: params[:user][:email])
            render :new, status: :unprocessable_entity
        end
    end

    def show
        @user = User.find_by(id: params[:id])
        render :show
    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
    end
end