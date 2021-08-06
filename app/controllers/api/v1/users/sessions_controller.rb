# frozen_string_literal: true
class Api::V1::Users::SessionsController < Devise::SessionsController
  before_action :sign_in_params, only: [:create, :load_user]
  before_action :load_user
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    if @user.valid_password?(sign_in_params[:password])
      sign_in "user", @user
      render json: {
        messages: 'Signed in Successfully',
        is_success: true,
        data: {
          user: @user
        },
      }, status: :ok
    end
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    if signed_out
      render json: { 
        messages: 'Signed Out Successfully',
        is_success: true,
        data: {
          user: @user
        },
      }, status: :ok
    end
  end

  protected

  def load_user
    @user = User.find_for_database_authentication(email: sign_in_params[:email])
    if !@user.nil?
      return @user
    end
  end
  # If you have extra params to permit, append them to the sanitizer.
  def sign_in_params
    params.require(:sign_in).permit(:email, :password)
  end
end
