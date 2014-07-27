class UsersController < ApplicationController
    def create
        @user = User.new(params[:user])
        if @user.save
            render json: @user
        else
            render status: 400
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
    end

    def index
        @users = User.all
        render json: @users
    end

    def show
        @user = User.includes(:entries, :races).find(params[:id])
        render json: @user.as_json(include: { entries: { include: :race } })
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(params[:user])
            render json: @user.as_json(include: { entries: { include: :race } })  
        else
            render status: 400
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
