class SessionsController < ApplicationController
    before_action :require_logged_in, only:[:destroy]
    before_action :require_logged_out, only:[:new, :create]

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])

        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            @user = User.new(email: params[:user][:email])
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        logout!
        redirect_to new_session_url
    end
end