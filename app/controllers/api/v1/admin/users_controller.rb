class Api::V1::Admin::UsersController < ApplicationController

    def index
        @users = User.all
        render json: @users
    end
end
