class UsersController < ApplicationController

  before_action :authenticate_client, :except => [:expired_pro]

  def render_unauthorized
    render :json => {:error => {:message => "Unauthorized."}}, :status => 401
  end

  def authenticate_client
    if params[:client_secret] != ENV["CLIENT_SECRET"]
      render_unauthorized
    end
  end

  def create
    user = User.find_or_create_by(:email => params[:email])
    if !user.key
      user.key = Digest::SHA256.hexdigest(SecureRandom.random_bytes(32))
    end
    user.update!(user_params)
    user.save
    render :json => user
  end

  def expired_pro
    # renders html
  end

  private

  def user_params
    params.permit(:email, :pro_enabled)
  end

end
